module ALU(
  input [31:0] input1, input2,
  input [3:0] ALU_Con,
  output reg [31:0] ALUout,
  output reg eq_true,
  output reg [31:0] hi, low
);
  always @(*) begin
    case (ALU_Con)
      4'b0000: ALUout = input1 + input2;
      4'b0001: ALUout = input1 - input2;
      4'b0010: ALUout = input1 & input2;
      4'b0011: ALUout = input1 | input2;
      4'b0100: ALUout = input1 ^ input2;
      4'b0101: ALUout = input1 << input2;
      4'b0110: ALUout = input1 >> input2;
      default: ALUout = 32'b0;
    endcase
    eq_true = (input1 == input2);
    hi = 32'b0;
    low = 32'b0;
  end
endmodule