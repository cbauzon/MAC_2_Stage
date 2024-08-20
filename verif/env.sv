class env extends uvm_env;
    `uvm_component_utils(env)

    seqr seqr_h;
    drvr drvr_h;

    imon imon_h;
    omon omon_h;

    mult mult_h;
    acc acc_h;
    comp comp_h;

    uvm_tlm_analysis_fifo #(dut_signals) comp_fifo_expected;

    function new(string name="env", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        comp_fifo_expected = new("comp_fifo_expected");
        uvm_config_db #(uvm_tlm_analysis_fifo #(dut_signals))::set(null, "*", "friend", comp_fifo_expected);
        seqr_h = seqr::type_id::create("seqr_h", this);
        drvr_h = drvr::type_id::create("drvr_h", this);
        imon_h = imon::type_id::create("imon_h", this);
        omon_h = omon::type_id::create("omon_h", this);
        mult_h = mult::type_id::create("mult_h", this);
        comp_h = comp::type_id::create("comp_h", this);

        acc_h = acc::type_id::create("acc", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drvr_h.seq_item_port.connect(seqr_h.seq_item_export);
        imon_h.imon_port.connect(mult_h.mult_fifo.analysis_export);
        mult_h.mult_port.connect(acc_h.acc_fifo.analysis_export);
        acc_h.acc_port.connect(comp_h.comp_fifo_expected.analysis_export);
        omon_h.omon_port.connect(comp_h.comp_fifo_actual.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        seq bob = new("bob");
        phase.raise_objection(this);
        bob.start(seqr_h);
        phase.drop_objection(this);
    endtask
endclass