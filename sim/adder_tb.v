`timescale 1ns/1ps

module adder_tb();

reg cin, in1, in2;
wire sum, cout;

full_adder uut (
    .cin(cin),
    .in1(in1),
    .in2(in2),
    .sum(sum),
    .cout(cout)
);

initial begin
    // Display header
    $display("cin in1 in2 | sum cout");
    $display("----------------------");

    // Test all input combinations
    cin = 0; in1 = 0; in2 = 0; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 0; in1 = 0; in2 = 1; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 0; in1 = 1; in2 = 0; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 0; in1 = 1; in2 = 1; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 1; in1 = 0; in2 = 0; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 1; in1 = 0; in2 = 1; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 1; in1 = 1; in2 = 0; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    cin = 1; in1 = 1; in2 = 1; #10;
    $display(" %b   %b   %b |  %b    %b", cin, in1, in2, sum, cout);

    $finish;
end

endmodule

