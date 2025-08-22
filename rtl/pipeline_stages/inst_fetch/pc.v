
module pc(
    input wire clk,
    input wire rst,
    input wire busy,
    input wire jump_flag,
    input wire [3:0] jump_addr,
    output reg [3:0] pc_out
);

    always@(posedge clk or posedge rst) begin

        if(rst) begin
            pc_out <= 0;
        end else if (!busy) begin 
            if(jump_flag) begin
                pc_out = jump_addr;
            end else begin
                pc_out = pc_out + 1;
            end
        end
    end

endmodule
            