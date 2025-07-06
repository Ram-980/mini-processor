module processor_tb;
 
  reg clk, rst;
  reg [31:0] instr, data;
  reg [9:0] instr_addr, data_addr;
  reg ins_we, data_we;
  wire [31:0] processor_out;
  wire done;
 
  // Instantiate the processor
  processor_top uut (
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .instr_addr(instr_addr),
    .data(data),
    .data_addr(data_addr),
    .ins_we(ins_we),
    .data_we(data_we),
    .processor_out(processor_out),
    .done(done)
  );
 
  // Clock generation
  always #5 clk = ~clk;
 
  // Helper task to write instruction to instruction memory
  task load_instr;
    input [9:0] addr;
    input [31:0] value;
    begin
      @(posedge clk);
      instr_addr = addr;
      instr = value;
      ins_we = 1;
      @(posedge clk);
      ins_we = 0;
    end
  endtask
 
  // Helper task to write data to data memory
  task load_data;
    input [9:0] addr;
    input [31:0] value;
    begin
      @(posedge clk);
      data_addr = addr;
      data = value;
      data_we = 1;
      @(posedge clk);
      data_we = 0;
    end
  endtask
 
  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    ins_we = 0;
    data_we = 0;
    instr = 32'b0;
    data = 32'b0;
    instr_addr = 10'b0;
    data_addr = 10'b0;
 
    #10 rst = 0;
 
    // Load instructions
    // Example program: add $t0, $t1, $t2 => opcode=0, rs=9, rt=10, rd=8, shamt=0, funct=32
    load_instr(10'd0, 32'b000000_01001_01010_01000_00000_100000); // add $t0, $t1, $t2
    load_instr(10'd1, 32'b000000_01010_01011_01001_00000_100000); // add $t1, $t2, $t3
    load_instr(10'd2, 32'b000000_00000_00000_00000_00000_001000); // halt (using jr $zero)
 
    // Load data (if needed)
    // load_data(10'd0, 32'd5);
 
    // Let the processor run
    #200;
 
    $display("Processor Output: %d", processor_out);
    $finish;
  end
endmodule