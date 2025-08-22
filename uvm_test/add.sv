interface add_if();
    logic [3:0] a, b;
    logic [4:0] sum;

endinterface

module add(add_if if);
    assign if.sum = if.a +if.b;
endmodule