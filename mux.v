module mux1bit (a,b,s,out);
input wire a,b,s;
output wire out;
assign out = a&(~s) | b&s; // output based on select signal
endmodule

// 32-bit MUX module using 1-bit MUX
module mux32bit (a,b,s,out);
input wire[31:0] a,b;
output wire[31:0] out;
input s;

// Instantiate an array of 32 1-bit MUXes to create a 32-bit MUX
mux1bit arr[31:0] (.a(a) , .b(b) , .s({32{s}}) , .out(out)); // s signal is replicated 32 times
endmodule

// 4-option 32-bit MUX module
module mux32bit_4option (a,b,c,d,s,zero,out);
input wire[31:0] a,b,c,d;
input wire[1:0] s;
input wire zero;
output reg[31:0] out;

// Based on the select signal, output the corresponding input
always @(*) begin
    case(s)
    2'b00: out<=a; // s=00, output=a
    2'b01: begin
        if (zero)
            out<=b; // s=01, output=b if zero=1, otherwise output=a
        else
            out<=a;
    end
    2'b10: out<=c; // s=10, output=c
    2'b11: out<=d; // s=11, output=d
    endcase
end
endmodule