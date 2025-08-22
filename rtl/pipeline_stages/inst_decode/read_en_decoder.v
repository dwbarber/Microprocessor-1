//USELESS
module read_en_decoder(
    input [1:0] re_1_sel,
    input [1:0] re_2_sel,
    output s1, 
    output s2, 
    output s3, 
    output s4 
);

    assign s1 = (~re_1_sel[1] & ~re_1_sel[0]) | (~re_2_sel[1] & ~re_2_sel[0]);
    assign s2 = (~re_1_sel[1] & re_1_sel[0]) | (~re_2_sel[1] & re_2_sel[0]);
    assign s3 = (re_1_sel[1] & ~re_1_sel[0]) | (re_2_sel[1] & ~re_2_sel[0]);
    assign s4 = (re_1_sel[1] & re_1_sel[0]) | (re_2_sel[1] & re_2_sel[0]);

endmodule