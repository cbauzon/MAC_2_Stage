class omon extends uvm_monitor;
    `uvm_component_utils(omon)

    // declare vif
    virtual mac_intf vif;

    // declare messages
    uvm_analysis_port #(dut_signals) omon_port;
    dut_signals mx;

    logic [31:0] prev_out = 'x;

    function new(string name="omon", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual mac_intf)::get(null, "*", "intf", vif)) begin
            `uvm_fatal("OMON", "Failed to get virtual interface!")
        end

        omon_port = new("omon_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        mx = new();

        forever begin
            @(vif.out)
            if (prev_out === 'x) begin
                prev_out = vif.out;
            end else begin
                mx.out = vif.out;
                `uvm_info("OMON", "Captured change in output!", UVM_MEDIUM)
                omon_port.write(mx);
            end
            
        end
    endtask
endclass