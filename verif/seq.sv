class seq extends uvm_sequence #(dut_signals);
    `uvm_object_utils(seq)

    // declare messages
    dut_signals mx;

    // declare rpx
    int rpx = 5;

    function new(string name="seq");
        super.new(name);
    endfunction

    task body();
        mx = new();

        do_rst(3);

        // start_item(mx);
        // mx.rst = 1;
        // finish_item(mx);

        repeat(rpx) begin
            start_item(mx);
            mx.rst = 1;
            mx.randomize() with {A != 0; B != 0;};
            finish_item(mx);
        end

        do_rst(5);

        repeat(rpx) begin
            start_item(mx);
            mx.rst = 1;
            mx.randomize() with {A != 0; B != 0;};
            finish_item(mx);
        end
        
        #50;
    endtask

    task do_rst(int rpt);
        repeat (rpt) begin;
            start_item(mx);
            mx.rst = 0;
            finish_item(mx);
        end

    endtask
endclass