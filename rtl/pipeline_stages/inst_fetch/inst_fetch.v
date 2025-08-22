
module inst_fetch(
    input clk,
    input rst,
    input jump_flag,
    input [3:0] jump_addr,
    output [7:0] inst,
    output [3:0] inst_addr
);

    wire [3:0] current_pc;

    pc pc(
        .clk(clk),
        .rst(rst),
        .busy(0),
        .jump_flag(jump_flag),
        .jump_addr(jump_addr),
        .pc(current_pc)
    );

    memory inst_memory(
        .clk(clk),
        .rst(rst),
        .addr(current_pc),
        .re(1),
        .we(0),
        .data_bus(inst)
    );

    assign inst_addr = current_pc;

endmodule