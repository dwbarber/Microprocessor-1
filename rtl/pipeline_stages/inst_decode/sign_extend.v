module sign_extend(
    input [3:0] in, //FLAG: currently assuming that the value in the immediate can only be 6 bits wide
    output [DATAWIDTH-1:0] out
)

assign output = {4'b00, in};

endmodule


