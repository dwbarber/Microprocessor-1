module two_four_decoder(
    input none, //used to set all output signals to 0
    input [1:0] select,
    output s1, 
    output s2, 
    output s3, 
    output s4 
);

    assign s1 = ~none & ~select[1] & ~select[0];
    assign s2 = ~none & ~select[1] & select[0];
    assign s3 = ~none & select[1] & ~select[0];
    assign s4 = ~none & select[1] & select[0];

endmodule