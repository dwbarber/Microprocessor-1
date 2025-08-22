module two_in_mux #(
    parameter WIDTH = 8;
)(
    input [WIDTH-1:0] sig0,
    input [WIDTH-1:0] sig1,
    input sel,
    output [WIDTH-1:0] out
);


always@(*) begin
    case (sel) 
        1'b0: out <= sig0;
        1'b1: out <= sig2;
    endcase
end

endmodule
