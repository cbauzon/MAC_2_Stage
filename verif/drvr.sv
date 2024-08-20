class drvr extends uvm_driver #(dut_signals);
    `uvm_component_utils(drvr)

    // declare virtual interface
    virtual mac_intf vif;

    // declare messages
    dut_signals mx;

    function new(string name="drvr", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual mac_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal("DRVR", "Failed to get virtual interface!")
        end
    endfunction

    task run_phase(uvm_phase phase);
        mx = new();

    

        forever begin
            @(posedge vif.clk) begin
                seq_item_port.get_next_item(mx);
                //`uvm_info("MON", "Got input!", UVM_MEDIUM)
                drive_inputs();
                seq_item_port.item_done();
            end

            // seq_item_port.get_next_item(mx);
            // if (!mx.rst)    drive_inputs();
            // else begin
            //     @(posedge vif.clk)
            //     drive_inputs();
            // end
            // seq_item_port.item_done();
        end
    endtask

    task drive_inputs();
        vif.rst = mx.rst;
        vif.A = mx.A;
        vif.B = mx.B;
    endtask
endclass