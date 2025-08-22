`timescale 1ns/1ps

module alu_tb();

    reg a;
    reg b;
    reg [1:0] alu_op;
    wire overflow;
    wire out;

    alu uut(
        .alu_op(alu_op),
        .in_one(a),
        .in_two(b),
        .out(out),
        .o(overflow)
        .c(),
        .z()
    );

    initial begin
       a=8'b0;
       b=8'b0;
       alu_op = 2'b00;

       #2;

        $stop

    end

endmodule

