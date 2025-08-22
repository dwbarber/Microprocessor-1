module register_file #(
    parameter DATA_WIDTH=8
    )( 
    input clk,
    input rst, //resets ALL registers
    input [1:0] re_1,
    input [1:0] re_2,
    input [1:0] we,
    input no_write,
    input [DATA_WIDTH-1:0] write_data,
    output [DATA_WIDTH-1:0] data_1,
    output [DATA_WIDTH-1:0] data_2
);

    wire read_1, read_2, read_3, read_4;
    wire write_1, write_2, write_3, write_4;

    //REGISTERS
    register #(DATA_WIDTH) r1 (
        .clk(clk),
        .rst(rst),
        .re(read_1),
        .we(write_1),
        .in(write_data)
        .Q(q_1)
    );

    register #(DATA_WIDTH) r2 (
        .clk(clk),
        .rst(rst),
        .re(read_2),
        .we(write_2),
        .in(write_data)
        .Q(q_2)
    );

    register #(DATA_WIDTH) r3(
        .clk(clk),
        .rst(rst),
        .re(read_3),
        .we(write_3),
        .in(write_data)
        .Q(q_3)
    );

    register #(DATA_WIDTH) r4(
        .clk(clk),
        .rst(rst),
        .re(read_4),
        .we(write_4),
        .in(write_data)
        .Q(q_4)
    );

    //write enable decoder to select which register gets a write
    two_four_decoder we_decoder(
        .none(no_write),
        .select(we),
        .s1(write_1),
        .s2(write_2),
        .s3(write_3),
        .s4(write_4),
    );

    //read enable decoders
    four_in_mux data_1(
        .sig1(q_1),
        .sig2(q_2),
        .sig3(q_3),
        .sig4(q_4),
        .sel(re_1)
        .out(data_1)
    );

    four_in_mux data_2(
        .sig1(q_1),
        .sig2(q_2),
        .sig3(q_3),
        .sig4(q_4),
        .sel(re_2)
        .out(data_2)
    );

endmodule