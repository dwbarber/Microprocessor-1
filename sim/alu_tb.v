`timescale 1ns / 1ps

module alu_tb();

    reg [7:0] a, b;
    reg [1:0] op; // 2 bits for operation select: 00=add, 01=sub, 10=mul
    wire [15:0] result; // Adjust width if needed

    // Instantiate the ALU
    alu uut (
        .in_one(a),
        .in_two(b),
        .alu_op(op),
        .out(result)
    );

    initial begin
        // Test addition
        a = 8'd10; b = 8'd5; op = 2'b00; #10;
        $display("ADD: %d + %d = %d", a, b, result);

        // Test subtraction
        a = 8'd15; b = 8'd7; op = 2'b01; #10;
        $display("SUB: %d - %d = %d", a, b, result);

        // Test multiplication
        a = 8'd3; b = 8'd4; op = 2'b10; #10;
        $display("MUL: %d * %d = %d", a, b, result);

        $display("ALU testbench completed.");
        $stop;
    end

endmodule