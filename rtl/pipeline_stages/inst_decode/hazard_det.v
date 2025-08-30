module hazard_det(
    input clk,
    input rst,
    input [1:0] r1,
    input [1:0] r2,
    input [1:0] dst,
    output hazard_flag
);

reg [1:0] r1_ex, r2_ex, r1_ma, 
    r2_ma, r1_wb, r2_wb, 
    dst_ex, dst_ma, dst_wb;

initial begin
    r1_ex = 2'b0;
    r2_ex = 2'b0;
    r1_ma = 2'b0;
    r2_ma = 2'b0;
    r1_wb = 2'b0;
    r2_wb = 2'b0;
end

//shift register to keep track of sources and destinations
always@(posedge clk) begin
    r1_wb = r1_ma ;
    r1_ma = r1_ex;
    r1_ex = r1;

    r2_ma = r2_ex;
    r2_wb = r2_ma;
    r2_ex = r2;

    dst_wb = dst_ma;
    dst_ma = dst_ex;
    dst_ex = dst;

end

//FLAG: THIS IS PROBABLy INCORRECT

wire hazard_exe, hazard_mem;

// Hazard if decode stage needs a register that is being written in execute stage
assign hazard_ex = exe_reg_write &&
                    ((src_reg1 == exe_dest_reg && exe_dest_reg != 0) ||
                     (src_reg2 == exe_dest_reg && exe_dest_reg != 0));

// Hazard if decode stage needs a register that is being written in memory stage
assign hazard_ma = mem_reg_write &&
                    ((src_reg1 == mem_dest_reg && mem_dest_reg != 0) ||
                     (src_reg2 == mem_dest_reg && mem_dest_reg != 0));

assign hazard_flag = hazard_exe | hazard_mem;

endmodule

