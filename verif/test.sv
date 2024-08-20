class test extends uvm_test;
    `uvm_component_utils(test)

    // declare components
    env env_h;

    function new(string name="test", uvm_component par);
        super.new(name, par);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_h = env::type_id::create("env_h", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        print();
        //`uvm_info("TEST", "TEST", UVM_MEDIUM)
    endfunction
endclass