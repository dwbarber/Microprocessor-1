
module flop #(
    parameter WIDTH = 1
)(
    input wire clk,
    input wire reset,
    input wire [WIDTH-1:0] data,
    output reg [WIDTH-1:0] Q
);


    always@ (posedge clk or posedge reset) begin
        if (reset) begin
            Q <= {WIDTH{1'b0}};
        end else begin
            Q <= data;
        end
    end


endmodule