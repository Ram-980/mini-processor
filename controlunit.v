module ALU_controller (
 input wire [5:0] opcode , input wire[5:0] func , output reg [3:0] ALUctrl
);
 always @(opcode or func) begin
 if(opcode == 6'b000111 || opcode == 6'b001000) begin // lw or sw
 ALUctrl = 0; // add
 end
 else if(opcode == 1) begin // addi
 ALUctrl = 0;
 end
 else if(opcode == 2) begin // andi
 ALUctrl = 2;
 end
 else if(opcode == 3) begin // ori
 ALUctrl = 4;
 end
 else if(opcode == 4) begin // xori
 ALUctrl = 3;
 end
 else if(opcode == 5) begin // addui
 ALUctrl = 0;
 end
 else if(opcode == 6'b001001 || opcode == 6'b010100 || opcode == 6'b010110) begin // slti and ble , bleu
 ALUctrl = 10;
 end
 else if(opcode == 6'b001010 || opcode == 6'b010000) begin // seq, beq
 ALUctrl = 9;
 end
 else if(opcode == 6'b010001) begin // bne
 ALUctrl = 8;
 end
 else if(opcode == 6'b010010 || opcode == 6'b010111) begin // bgt ,bgtu
 ALUctrl = 12;
 end
 else if(opcode == 6'b010011) begin // bgte
 ALUctrl = 13;
 end
 else if(opcode == 6'b010101) begin // bleq
 ALUctrl = 11;
 end
 else if(opcode == 6'b001011) begin//lui
 ALUctrl = 14;
 end
 else begin
 if(opcode == 6'b000000) begin
 case (func)
 0: ALUctrl = 0;
 1: ALUctrl = 1;
 2: ALUctrl = 2;
 3: ALUctrl = 4;
 4: ALUctrl = 5;
 5: ALUctrl = 3;
 6: ALUctrl = 0;
 7: ALUctrl = 1;
 8: ALUctrl = 10;
 9: ALUctrl = 6;
 10: ALUctrl = 7;
 default: ALUctrl = 15;
 endcase
 end
 else begin
 ALUctrl = 4'b1111;
 end
 end
 end
endmodule
