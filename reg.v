module Register(
  input [4:0] rt, rs, WriteReg,
  input [31:0] WriteData,
  input Regwrt, input rst, input clk,
  output [31:0] Data1, Data2
);
  reg [31:0] registers[31:0];
  integer i;
  assign Data1 = registers[rs];
  assign Data2 = registers[rt];
 
  always @(posedge clk or posedge rst) begin 
 
    if (rst) begin
   
      for (i = 0; i < 32; i = i + 1) 
        registers[i] <= 32'b0;
    end else if (Regwrt) begin
      registers[WriteReg] <= WriteData;
    end
  end
endmodule