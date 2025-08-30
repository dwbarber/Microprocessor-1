
module inst_decode #(
    parameter DATA_WIDTH=8
    )(
    input clk,
    input rst,
    input [7:0] inst,
    input [1:0] dst_reg,
    input [DATA_WIDTH-1] wb_data,
    input no_write,
    output [7:0] r1_val,
    output [7:0] r2_val,
    output [7:0] immediate,
    output [1:0] alu_ctl,
    output alu_src_sel,
    output [1:0] dst_reg_out
);

sign_extend sign_extend(
    .in(inst[3:0]), //FLAG: assuming immediates are the last 4 bits of an instruciton
    .out(immediate)
);

register_file rf(
    .clk(clk),
    .rst(rst),
    .re_1(inst[3:2]),
    .re_2(inst[1:0]),
    .we(dst_reg_in),
    .no_write(no_write),
    .write_data(wb_data),
    .data_1(r1_val),
    .data_2(r2_val)
);

op_decoder op_decoder(
    .op_code(inst[7:4]),
    .dest_reg(dest_reg_out),
    .load_sel()
);
    


register

assign r1_val = 

endmodule
