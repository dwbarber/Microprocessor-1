`timescale 1ns / 1ps

module register_tb();

    // Testbench signals
    reg clk;
    reg rst;
    reg re;
    reg we;
    reg Q;
    wire [7:0] data_bus;
    reg [7:0] data_bus_driver; // Driver for data_bus when writing
    reg data_bus_en;       // Enable signal for driving data_bus

    // Bidirectional data bus logic
    assign data_bus = data_bus_en ? data_bus_driver : 8'bz;

    // Instantiate the register module
    register uut (
        .clk(clk),
        .rst(rst),
        .re(re),
        .we(we),
        .Q(Q),
        .data_bus(data_bus)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        re = 0;
        we = 0;
        data_bus_driver = 8'b0;
        data_bus_en = 0;

        // Reset the register
        rst = 1;
        #10;
        rst = 0;

        // Write data to the register
        data_bus_driver = 8'hA5; // Example data
        data_bus_en = 1;     // Enable driving the data bus
        we = 1;
        #10;
        we = 0;
        data_bus_en = 0;     // Disable driving the data bus
        #100;

        // Read data from the register
        re = 1;
        #10;
        re = 0;

        // Write another value to the register
        data_bus_driver = 8'h3C; // Another example data
        data_bus_en = 1;
        we = 1;
        #10;
        we = 0;
        data_bus_en = 0;
        #100;

        // Read the new value from the register
        re = 1;
        #10;
        re = 0;

        $stop(2); //print info about tb
    end

endmodule
