`define DATA_WIDTH 8

module topmod(
    input wire sys_clk,
    input wire sys_rst
);

    /***** SIGNAL INSTANTIATION *******/
    //fetch stage signals
    reg [3:0] inst_addr_if;

    //decode stage signals
    reg [7:0] inst_id;
    reg [3:0] inst_addr_de; //piped through for a jump
    reg [3:0] op_code_id;

    reg [1:0] dst_reg_id;

    reg jump_flag_id; 

    wire [1:0] 
        src_reg_1_id, 
        src_reg_2_id, 
        dst_reg_id;

    wire [DATA_WIDTH-1:0] 
        src_data_1_id, 
        src_data_2_id,  
        immediate_id;

    //execute stage signals
    reg src_sel_ex;
    reg [1:0] alu_ctl_ex; 

    reg [1:0] dst_reg_ex; //piped through for a register write

    reg jump_flag_ex;
    reg [3:0] inst_addr_ex; //piped through for a jump


    wire [DATA_WIDTH-1:0] 
        src_data_1_ex, 
        src_data_2_ex,  
        immediate_ex;
        alu_out_ex;

    //memory access stage signals
    reg jump_flag_ma;
    reg [3:0] jump_addr_ma; //brought back to if stage

    reg [1:0] dst_reg_ma;

    reg [3:0] 
        wr_en_ma, 
        rd_en_ma;

    reg [DATA_WIDTH-1:0] data_ma;


    //writeback stage signals
    reg [1:0] dst_reg_wb;

    reg [DATA_WIDTH-1:0] 
        data_1_wb, 
        data_2_wb, 
        dst_data_wb;


    /***** MODULE INSTANTIATION *******/

    inst_fetch inst_fetch(
        .clk(sys_clk),
        .rst(sys_rst),
        .jump_flag(jump_flag_ma),
        .jump_addr(jump_addr_ma),
        .inst(inst_de),
        .inst_addr(inst_addr_if)
    );


    inst_decode inst_decode(
        .clk(sys_clk),
        .rst(sys_rst),
        .inst(inst_de),
        .dst_reg_in(dst_reg_wb),
        .wb_data(),
        .no_write(),
        .r1_val(),
        .r2_val(),
        .immediate(),
        .alu_ctl(),
        .alu_src_sel(),
        .dst_reg_out(dst_reg_id),
    );

    execute execute(
        .immediat(),
        .val_1(),
        .val_2(),
        .alu_ctl(),
        .alu_src_ctl(),
    );
     
    mem_access mem_access(

    );

    write_back write_back(

    );


//clock boundary assignments

    always@(posedge sys_clk) begin         
        // if - id 
        inst_addr_de <= inst_addr_if;

        // id - ex 
        dst_reg_id <= dst_reg_ex;

        // ex - ma 
        dst_reg_ex <= dst_reg_ma;

        // ma - wb 
        dst_reg_ma <= dst_reg_wb;
    end

endmodule

