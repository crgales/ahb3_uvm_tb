import uvm_pkg::*;
`include "uvm_macros.svh"

import ahb_test_pkg::*;

module top;
  bit clk, reset_n;

  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end

  initial begin
    reset_n = 1'b0;
    repeat (10) @(posedge clk);
    reset_n = 1'b1;
  end

  ahb_if ahb_intf(clk, reset_n);

  initial begin
    uvm_config_db #(virtual ahb_if)::set(null,"uvm_test_top","ahb_vif",ahb_intf);
    run_test();
  end

endmodule : top