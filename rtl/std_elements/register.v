
module register #(
    parameter DATA_WIDTH=8
    )(
    input clk,
    input rst,
    input re,
    input we,
    input [DATA_WIDTH-1:0] in,
    output [7:0] Q
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= {DATA_WIDTH{1'b0}};
        end else if (we) begin
            Q <= in;
        end
    end

endmodule