class dut_signals extends uvm_sequence_item;
    // inputs
    logic rst;
    rand logic [7:0] A;
    rand logic [7:0] B;

    // outputs
    logic [31:0] out;

    `uvm_object_utils_begin(dut_signals)
        `uvm_field_int(rst, UVM_ALL_ON)
        `uvm_field_int(A, UVM_ALL_ON)
        `uvm_field_int(B, UVM_ALL_ON)
        `uvm_field_int(out, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="dut_signals");
        super.new(name);
    endfunction

endclass