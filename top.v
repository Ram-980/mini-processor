`include "memory.v"
`include "Control Unit.v"
`include "ALU.v"
`include "mux.v"
'include "reg.v"
module top (rst, clk);
 wire [9:0] PC;
    wire [31:0] instruction;
    wire [31:0] ALU_out;
    wire [9:0] memory_in;
    wire [31:0] rt_out , rs_out , memory_write , memory_out , rt_or_address_to_ALU, extended_address;
    wire [4:0] rt , rs , rd , shamt;
    wire [5:0] opcode , func;
    wire [15:0] address_constant;
    wire [25:0] jaddress; 
    wire branch , jump , jal , mem_write , immediate, select_ALU_or_Mem, write_reg;
    //mem_write instead of data_write
    wire [3:0] ALUctrl;

    assign OutputOfRs = rs_out;

    //this thing is to handle jal
    wire[4:0] write_in_Register;
    assign write_in_Register = (jal)? 5'd3 : rd;
    wire [31:0] write_data_in_register , wire_going_into_register_rd;
    assign wire_going_into_register_rd = (jal)? {22'b0 , PC} : write_data_in_register; 

    assign opcode = instruction[31:26];
    assign rd = instruction[25:21];
    assign rt = instruction[20:16];
    assign rs = instruction[15:11];
    assign shamt = instruction[10:6];
    assign func = instruction[5:0];
    assign address_constant = instruction[15:0];
    assign jaddress = instruction[25:0];

    mux32bit_4option PC_next_decider(PCplus1, branch_addr, jr_addr, j_addr, PCcontrol, ALUout, PC_next);

mux32bit input2_decider(rt_data, Immediate, ALUsrc, input2);
ALU alu(input1, input2, shamt, Alucontrol, ALUout, ALUzero);
Text instruction (.rst(rst), .clk(clk), .r_addr(PC), .w_addr(unused32), .w_en(unused1), .din(unused32), .dout(IR));
Data var (.rst(rst), .clk(clk), .r_addr(ALUout), .w_addr(ALUout), .w_en(MemWrite), .din(rt_data), .dout(ReadData));

   

    always @(posedge clk ) begin
        if(rst) begin
            immediate <= 0;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            data_write <= 0;
            write_reg <= 0;
            jal <= 0;
        end
        else if(opcode == 0) begin // Rtype instruction
            immediate <= 0;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 1;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode <= 5) begin //addi, andi , xori, ori , addiu
            immediate <= 1;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 1;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode == 7) begin // lw
            immediate <= 1;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 1;
            write_reg <= 1;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode == 8) begin // sw
            immediate <= 1;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 0;
            data_write <= 1;
            jal <= 0;
        end
        else if(opcode == 9 || opcode == 10) begin // slti , seq
            immediate <= 1;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 1;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode == 6'b001011) begin
            immediate <= 1;
            jump <= 0;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 1;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode <= 23) begin //all branches
            immediate <= 0;
            jump <= 0;
            branch <= 1;
            select_ALU_or_Mem <= 0;
            write_reg <= 0;
            data_write <= 0;
            jal <= 0;
        end
        else if(opcode != 6'b011010) begin // All jump except jal
            immediate <= 0;
            jump <= 1;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 0;
            data_write <= 0;
            jal <= 0;
        end
        else begin // jal handled seperately as it requires to store the value of PC + 4 into $ra
            immediate <= 0;
            jump <= 1;
            branch <= 0;
            select_ALU_or_Mem <= 0;
            write_reg <= 1;
            data_write <= 0;
            jal <= 1;
        end
    end

    reg RAM(.rd(write_in_Register) , .rs(rs) , .rt(rt) , .clk(clk) , .we(write_reg) , .write_data(wire_going_into_register_rd) , .rst(rst));
    
    controlunit tb(.opcode(opcode) , .func(func) , .ALUctrl(ALUctrl));

    alu t(.inp1(rs_out) , .inp2(rt_or_address_to_ALU) , .ALUctrl(ALUctrl) , .clk(clk) , .ALUout(ALU_out) , .shamt(shamt));

    pc u(.clk(clk) , .PC(PC) , .rst(rst) , .jump(jump) , .jaddress(jaddress));

    endmodule
