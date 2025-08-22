`timescale 1ns/1ps

module pc_tb();

   reg clk;
   reg rst;
   reg busy; 
   reg jump_flag;
   reg [3:0] jump_addr;
   wire [3:0] pc_out;
   
   pc uut(
       .clk(clk),
       .rst(rst),
       .busy(busy),
       .jump_flag(jump_flag),
       .jump_addr(jump_addr),
       .pc_out(pc_out)
   );
   
   always #5 clk = ~clk; //rising edge every 10ns
   
   initial begin
       //set signals
       clk = 0;
       rst = 0;
       jump_flag = 0;
       jump_addr = 4'b0000;
       busy = 0;
   
       //reset pc
       rst = 1;
       #5;
       rst = 0;
   
       #100; //10 clock cycles
       rst = 1;
       #5;
       rst = 0;
   
       //JUMP
       #10;//2 clock cycles
       jump_flag = 1;
       jump_addr = 4'b1010;
       #10; //1 clock cycle
       jump_flag = 0;
       jump_addr = 4'b0000;
       #50; //5 clock cycles

       //reset pc
       rst = 1;
       #5;
       rst = 0;
   
       #50;//5 clock cycles
       busy = 1;
       #30; //busy for 3 cycles
       busy = 0;
       #50; //5 clock cycles
       rst = 1;
       #5;
       rst = 0;
   
       #50; //5 clock cycles

       $stop;
   end

endmodule