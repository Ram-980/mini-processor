module pc (
    input clk , output reg [9:0] PC, input rst , input jump , input [25:0] jaddress , input branch , input [15:0] branchval 
);

    always @(posedge clk ) begin
        if(rst) begin
            PC <= 0;
        end
        else begin
            if(jump) begin
                PC <= jaddress;
            end
            else if(branch) begin
                PC <= PC + 1 + branchval;
            end
            else begin
                PC <= PC + 1;
            end
        end
    end
    
endmodule