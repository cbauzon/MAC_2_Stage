class acc extends uvm_scoreboard;
    `uvm_component_utils(acc)

    // declare messages
    uvm_tlm_analysis_fifo #(dut_signals) acc_fifo;
    dut_signals mx_in;

    uvm_tlm_analysis_fifo #(dut_signals) fifo_in_comp;

    uvm_analysis_port #(dut_signals) acc_port;
    dut_signals mx_out;

    // variables
    logic [31:0] accumulated = 0;

    function new(string name="acc", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        acc_fifo = new("acc_fifo", this);
        acc_port = new("acc_port", this);
        if (!uvm_config_db #(uvm_tlm_analysis_fifo #(dut_signals))::get(null, "*", "friend", fifo_in_comp)) begin
            `uvm_fatal("ACC", "DIDN'T GET THE HANDLE")
        end
    endfunction

    task run_phase(uvm_phase phase);
        

        forever begin
            mx_in = new();
            mx_out = new();
            acc_fifo.get(mx_in);
            //`uvm_info("ACC", $sformatf("GOT MESSAGE!\n%s", mx_in.sprint()), UVM_MEDIUM)

            if (!mx_in.rst) begin
                accumulated = 0;
                mx_out.out = 0;
                fifo_in_comp.flush();
            end else begin
                accumulated = accumulated + mx_in.out;
                mx_out.out = accumulated;
            end
            mx_out.rst = mx_in.rst;

            `uvm_info("ACC", $sformatf("Writing to port! Out = %h", mx_out.out), UVM_MEDIUM)
            acc_port.write(mx_out);

        end
    endtask

endclass