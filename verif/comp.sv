class comp extends uvm_scoreboard;
    `uvm_component_utils(comp)

    // declare messages
    uvm_tlm_analysis_fifo #(dut_signals) comp_fifo_expected;
    uvm_tlm_analysis_fifo #(dut_signals) comp_fifo_actual;
    dut_signals expected, actual;

    function new(string name="comp", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // comp_fifo_expected = new("comp_fifo_expected", this);
        comp_fifo_actual = new("comp_fifo_actual", this);

        if (!uvm_config_db #(uvm_tlm_analysis_fifo #(dut_signals))::get(null, "*", "friend", comp_fifo_expected)) begin
            `uvm_fatal("COMP", "DIDN'T GET THE HANDLE")
        end        
    endfunction

    task run_phase(uvm_phase phase);
        expected = new();
        actual = new();


        forever begin            
            comp_fifo_expected.get(expected);
            comp_fifo_actual.get(actual);
            // if (!expected.rst) begin
            //     comp_fifo_expected.flush();
            //     expected.out = 0;
            //     `uvm_info("COMP1", $sformatf("Comparing Expected: %h, Actual: %h", expected.out, actual.out), UVM_MEDIUM)

            // end
            
            `uvm_info("COMP2", $sformatf("Comparing Expected: %h, Actual: %h", expected.out, actual.out), UVM_MEDIUM)

                        

        end
    endtask
endclass