class mult extends uvm_scoreboard;
    `uvm_component_utils(mult)
    
    // declare messages
    uvm_tlm_analysis_fifo #(dut_signals) mult_fifo;
    dut_signals mx_in;

    uvm_analysis_port #(dut_signals) mult_port;
    dut_signals mx_out;

    function new(string name="mult", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mult_fifo = new("mult_fifo", this);
        mult_port = new("mult_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        
        forever begin
            mx_in = new();
            mx_out = new();

            mult_fifo.get(mx_in);
            mx_out.rst = mx_in.rst;
            mx_out.out = mx_in.A * mx_in.B;

            mult_port.write(mx_out);
        end
    endtask
endclass