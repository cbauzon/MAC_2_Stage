class imon extends uvm_monitor;
    `uvm_component_utils(imon)

    // declare virtual interface
    virtual mac_intf vif;

    // declare messages
    uvm_analysis_port #(dut_signals) imon_port;
    dut_signals mx;

    logic prev_rst = 1'bx;

    function new(string name="imon", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual mac_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal("IMON", "Failed to get virtual interface!")
        end

        imon_port = new("imon_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        mx = new();

        forever begin
            @ (vif.rst, vif.A, vif.B) begin
            if (prev_rst === 1'bx) begin
                prev_rst = vif.rst;
            end else begin
                mx.rst = vif.rst;
                mx.A = vif.A;
                mx.B = vif.B;
                `uvm_info("IMON", $sformatf("Got a change at input!"), UVM_MEDIUM)
                imon_port.write(mx);
            end
               
            
            end
        end
    endtask

endclass