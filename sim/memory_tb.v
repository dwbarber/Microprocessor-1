`timescale 1ns/1ps

module memory_tb();

reg clock;
reg rst;
reg [3:0] addr;
reg re;
reg we;
wire [7:0] data_bus;
reg [7:0] data_bus_driver;
reg data_bus_en;

assign data_bus = data_bus_en ? data_bus_driver : 8'bz;

memory uut(
    .clk(clock),
    .rst(rst),
    .addr(addr),
    .re(re),
    .we(we),
    .data_bus(data_bus)
);

always #5 clock = ~clock;

initial begin
    clock = 0;
    rst = 0;
    addr = 4'b0000;
    re = 0;
    we = 0;
    data_bus_en = 0;
    data_bus_driver = 0;

    //initialize by reseting memory
    rst = 1;
    #10;
    rst = 0;

    //write to address 2
    #15;
    we = 1;
    addr = 2;
    data_bus_driver = 8'b10110101;

    #10;
    we = 0;
    addr = 8;//change address
    data_bus_driver = 8'h02; //change input to databus

    #20;
    re = 1; //read from address 8 (should be 0)
    #10;
    re = 0; //read from address 8 (should be 0)
    addr = 2;//change address
    #20;
    re = 1; //read from address 2 (should be 0)
    #10;


    rst = 1;
    #10;
    rst = 0;

    $stop(2); //print info about tb
    
end





endmodule