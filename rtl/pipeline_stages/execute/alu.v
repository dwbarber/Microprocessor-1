module alu(
    input wire [1:0] alu_op,
    input wire [7:0] in_one,
    input wire [7:0] in_two,
    output reg [7:0] out,
    output reg o,
    output reg c,
    output reg z
);

    reg add_sub_sel;
    reg [1:0] out_sel;
    reg [1:0] add;
    reg [1:0] sub;
    reg [1:0] mult;

    

    adder_subtractor #(.WIDTH(8)) adder_inst(
        .in1(in_one),
        .in2(in_two),
        .op(alu_op[0])
        .o(o)
        .out(out)
    );

    

//    four_one_mux(
//        .sig0(add),
//        .sig1(sub),
//        .sig2(mult),
//        .sig3(in_one^in_two),
//        .sel(out_sel),
//        .out(out)
//    )



    endmodule 