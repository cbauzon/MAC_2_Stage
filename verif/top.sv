// include uvm macros
`include "uvm_macros.svh"

package top_pkg;
    import uvm_pkg::*;

    // include UVM tb files
    `include "msg_items.sv"
    `include "seq.sv"

    `include "mult.sv"
    `include "comp.sv"

    `include "acc.sv"
    
    `include "seqr.sv"
    `include "drvr.sv"
    `include "imon.sv"
    `include "omon.sv"
    
    `include "env.sv"
    `include "test.sv"
endpackage

// include top design
`include "../design/MAC.sv"

// include interface
`include "intf.sv"

module top;
    import uvm_pkg::*;
    import top_pkg::*;

    // define and generate clk
    logic clk;
    initial begin
        clk = 0;
        repeat (10000) #10 clk = !clk;
    end

    // instantiate interface
    mac_intf intf(clk);

    // connect DUT
    MAC_nbit DUT(
        .clk (clk),
        .rst (intf.rst),
        .A (intf.A),
        .B (intf.B),
        .out (intf.out)
    );

    initial begin
        uvm_config_db #(virtual mac_intf)::set(null, "*", "intf", intf);
        run_test("test");
    end

    initial begin
        $dumpfile("dut.vpd");
        $dumpvars(9, top);
    end
endmodule