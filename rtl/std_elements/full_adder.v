module full_adder(
    input wire cin,
    input wire in1,
    input wire in2,
    output wire sum,
    output wire cout
);

assign sum = (
    (!cin & !in1 & in2) | 
    (!cin & in1 & !in2) |
    (cin & !in1 & !in2) |
    (cin & in1 & in2) );


assign cout = (
    (in1 & in2) | 
    (cin & in1) |
    (cin & in2) );

endmodule