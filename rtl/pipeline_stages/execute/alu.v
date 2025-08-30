module alu(
    input  [1:0] alu_op,
    input  [7:0] in_one,
    input  [7:0] in_two,
    output [7:0] out
    //not currently using the flags (they are for branch prediction)
    //  output reg f_overflow,
    //  output reg f_carry,
    //  output reg f_zero
);

wire [8:0] add;
wire [8:0] sub;
wire [8:0] mul;

assign add = in_one + in_two;
assign sub = in_one - in_two;
assign mul = in_one * in_two;

four_in_mux mux(
    .sig1(add[7:0]),
    .sig2(sub[7:0]),
    .sig3(mul[7:0]),
    .sig4(in_one),
    .sel(op_code),
    .out(out)
)

//    always@(*) begin
//        case (alu_op) 
//            2'b00: out <= in_1 + in_2;
//            2'b01: out <= in_1 - in_2;
//            2'b10: out <= in_1 * in_2;
//            2'b11: out <= in_1; //pass-through source 1
//        endcase
//    end

endmodule

//original attempt using full adder and multiplier modules (incomplete) 

//    reg add_sub_sel;
//    reg [1:0] out_sel;
//    reg [1:0] add;
//    reg [1:0] sub;
//    reg [1:0] mult;
//
//    
//
//    adder_subtractor #(.WIDTH(8)) adder_inst(
//        .in1(in_one),
//        .in2(in_two),
//        .op(alu_op[0])
//        .o(o)
//        .out(out)
//    );

//    four_one_mux(
//        .sig0(add),
//        .sig1(sub),
//        .sig2(mult),
//        .sig3(in_one^in_two),
//        .sel(out_sel),
//        .out(out)
//    )