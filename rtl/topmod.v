`define DATA_WIDTH 8

module topmod #(
    parameter DATA_WIDTH=8
    )(
    input wire sys_clk,
    input wire sys_rst
);

    /***** SIGNAL INSTANTIATION *******/
    //fetch stage signals
    wire [3:0] inst_addr_if;
    wire [7:0] inst_if;

    //decode stage signals
    reg [3:0] inst_addr_id; //piped through for a jump
    wire [7:0] inst_id;
    wire       jump_flag_id; 
    wire       data_sel_id;
    wire       mem_re_id;
    wire       mem_we_id;
    wire [1:0] alu_ctl_id;
    wire       alu_src_sel_id;

    wire [DATA_WIDTH-1:0]  r1_val_id;
    wire [DATA_WIDTH-1:0]  r2_val_id;

    wire [DATA_WIDTH-1:0] imm_ase_id;     //immediate after sign extend (data width)
    wire [3:0] mem_addr_id;
    wire [1:0] dst_reg_id;



    //execute stage signals
    reg [3:0] inst_addr_ex;              //piped through for a jump
    wire [3:0] jump_addr_ex;              //piped through for a jump
    reg       jump_flag_ex; 
    reg       data_sel_id;
    reg       mem_re_ex;
    reg       mem_we_ex;
    reg [1:0] alu_ctl_ex;
    reg       alu_src_sel_ex;
    wire [DATA_WIDTH-1:0]  r1_val_ex;
    wire [DATA_WIDTH-1:0]  r2_val_ex;
    reg [DATA_WIDTH-1:0] imm_ase_ex;     //immediate after sign extend (data width)
    wire [DATA_WIDTH-1:0] alu_out_ex;
    reg [3:0] mem_addr_id;
    reg [1:0] dst_reg_ex;                //piped through for a register write


    //memory access stage signals
    reg [3:0] jump_addr_ma; //brought back to if stage
    reg       jump_flag_ma;
    reg [1:0] reg_we_ma;
    reg       data_sel_ma;
    reg       mem_re_ma;
    reg       mem_we_ma;
    wire [DATA_WIDTH-1:0] load_val_ma;
    reg [DATA_WIDTH-1:0] alu_out_ma;
    reg [3:0] mem_addr_ma;
    reg [1:0] dst_reg_ma;

    //writeback stage signals
    reg reg_we_wb;
    reg data_sel_wb;
    reg [1:0] dst_reg_wb;
    wire [DATA_WIDTH-1:0] load_val_wb;
    reg [DATA_WIDTH-1:0] alu_out_wb;
    wire [DATA_WIDTH-1:0] data_wb;
    reg [1:0] dst_reg_wb;


    /***** MODULE INSTANTIATION *******/

    inst_fetch inst_fetch(
        //inputs
        .clk(sys_clk),
        .rst(sys_rst),
        .jump_flag(jump_flag_ma),
        .jump_addr(jump_addr_ma),
        .inst(inst_if),
        .inst_addr(inst_addr_if)
    );


    inst_decode inst_decode(
        //inputs
        .clk(sys_clk),
        .rst(sys_rst),
        .inst_addr(inst_addr_id),
        .inst(inst_id),
        .reg_we(reg_we_wb),
        .data(data_wb),
        .dst_reg(dst_reg_wb),
        //outputs
        .jump_flag(jump_flag_id),
        .data_sel(data_sel_id),
        .mem_re(mem_re_id),
        .mem_we(mem_we_id),
        .alu_ctl(alu_ctl_id),
        .alu_src_sel(alu_src_sel_id),
        .r1_val(r1_val_id),
        .r2_val(r2_val_id),
        .imm_ase(imm_ase_id),
        .mem_addr(mem_addr_id),
        .dst_reg(dst_reg_id)
    );


    execute execute(
        //inputs
        .clk(sys_clk),
        .rst(sys_rst),
        .inst_addr(inst_addr_ex),
        .alu_ctl(alu_ctl_ex),
        .alu_src_sel(alu_src_sel_ex),
        .r1_val(r1_val_ex),
        .r2_val(r2_val_ex),
        .imm_ase(imm_ase_ex),
        //outputs
        .jump_addr(jump_addr_ex),
        .alu_out(alu_out_ex)
    );
     
    mem_access mem_access(
        //inputs
        .clk(sys_clk),
        .rst(sys_rst),
        .jump_addr(jump_addr_ma),
        .jump_flag(jump_flag_ma),
        .mem_re(mem_re_ma),
        .mem_we(mem_we_ma),
        .alu_out(alu_out_ma),
        .mem_addr(mem_addr_ma),
        //outputs
        .load_val(load_val_ma)
    );


    write_back write_back(
        //inputs
        .clk(sys_clk),
        .rst(sys_rst),
        .data_sel(data_sel_wb),
        .load_val(load_val_wb),
        .alu_out(alu_out_wb),
        //outputs
        .data(data_wb)
    );


    /***** PIPELINE STAGE BOUNDARIES *******/
    
    //clocked boundary assignments
    always@(posedge sys_clk) begin         
        // if - id 
        inst_addr_id <= inst_addr_if;

        // id - ex 
        inst_addr_ex   <=  inst_addr_id;
        jump_flag_ex   <=  jump_flag_id;
        reg_we_ex      <=  reg_we_id;
        data_sel_ex    <=  data_sel_id;
        mem_re_ex      <=  mem_re_id;
        mem_we_ex      <=  mem_we_id;
        alu_ctl_ex     <=  alu_ctl_id;
        alu_src_sel_ex <=  alu_src_sel_id;
        imm_ase_ex     <=  imm_ase_id;
        mem_addr_ex    <=  mem_addr_id;
        dst_reg_ex     <=  dst_reg_id;


        // ex - ma 
        jump_addr_ma   <=  jump_addr_ex;
        jump_flag_ma   <=  jump_flag_ex;
        reg_we_ma      <=  reg_we_ex;
        data_sel_ma    <=  data_sel_ex;
        mem_re_ma      <=  mem_re_ex;
        mem_we_ma      <=  mem_we_ex;
        alu_out_ma     <=  alu_out_ex;
        mem_addr_ma    <=  mem_addr_ex;
        dst_reg_ma     <=  dst_reg_ex;


        // ma - wb 
        reg_we_wb      <=  reg_we_ma;
        data_sel_wb    <=  data_sel_ma;
        alu_out_wb     <=  alu_out_ma;
        dst_reg_wb     <=  dst_reg_ma;

    end

    //non-clocked boundary assignments (due to clocked module outputs)
    // if - id 
    assign inst_id = inst_if;

    //id - ex
    assign r1_val_ex = r1_val_id;
    assign r2_val_ex = r2_val_id;

    //ma - wb
    assign load_val_wb = load_val_ma;

endmodule

