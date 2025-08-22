module adder_subtractor #(
    parameter WIDTH = 8
    )(
    input wire [WIDTH-1:0] in1,
    input wire [WIDTH-1:0] in2,
    input wire op, //0 add, 1 sub
    output wire overflow, //overflow
    output wire [WIDTH-1:0] out 
);

wire [WIDTH-1:0] b;
wire [WIDTH:0] carry; //carry has width+1 bits to be able to check for overflow
assign carry[0]=1'b0;
assign b = (op == 1'b0) ? in2 : ~in2; //invert bits if sub
//assign a = in1 ^ {WIDTH{sub}}; //alternative to above

genvar i;

generate
    for(i=0; i<WIDTH; i=i+1) begin
        full_adder fa(carry[i], in1[i], b[i], out[i], carry[i+1]);
    end

endgenerate

assign overflow = carry[WIDTH] ^ carry[WIDTH-1]; //detect overflow of 2s compliment

endmodule