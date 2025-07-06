module memo(a,d,dpra,clk,we,dpo);

input [9:0] a,dpra;
input clk,we;
output [31:0] dpo;
input [31:0] d; 
     
    dist_mem_gen_0 your_instance_name (
  .a(a),        // input wire [8 : 0] a
  .d(d),        // input wire [31 : 0] d
  .dpra(dpra),  // input wire [8 : 0] dpra
  .clk(clk),    // input wire clk
  .we(we),      // input wire we
  .dpo(dpo)    // output wire [31 : 0] dpo
);
endmodule