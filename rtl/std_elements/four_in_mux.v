

module four_in_mux #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] sig1,
    input [WIDTH-1:0] sig2,
    input [WIDTH-1:0] sig3,
    input [WIDTH-1:0] sig4,
    input [1:0] sel,
    output [WIDTH-1:0] out
);


always@(*) begin
    case (sel) 
        2'b00: out <= sig0;
        2'b01: out <= sig1;
        2'b10: out <= sig2;
        2'b11: out <= sig3;
    endcase
end

endmodule