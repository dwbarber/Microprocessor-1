

module memory #(
    parameter ADDR_SIZE = 4,
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input [ADDR_SIZE-1:0] addr,
    input re,
    input we,
    inout [WIDTH-1:0] data_bus 
    );

    reg [WIDTH-1:0] mem [0:2*ADDR_SIZE];

    assign data_bus = (re) ? mem[addr] : {WIDTH{1'bz}}; 

    always@(posedge clk or posedge rst) begin
        if (rst) begin
            mem[addr] <= {WIDTH{1'b0}};
        end else if (we) begin
            mem[addr] <= data_bus;
        end
    end
    
endmodule