module op_decoder(
    input [3:0] op_code,
    output jump,
    output [1:0] alu_control,
    output alu_src_sel,
    output dest_reg,
    output load_sel
)

    assign jump = (op_code == 4'b1000) ? 1 : 0;
    assign alu_control = 
        (op_code == ) ? 2'b00 :
        (op_code == ) ? 2'b01 :
        (op_code == ) ? 2'b10 :
        (op_code == ) ? 2'b11 :

    assign alu_source_select


endmodule