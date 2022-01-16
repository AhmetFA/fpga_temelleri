`ifndef uart_write_seq 
`define uart_write_seq

class uart_write_seq extends uvm_sequence#(uart_transaction);
    ///////////////////////////////////////////////////////////////////////////////
    // Declaration of variables
    //////////////////////////////////////////////////////////////////////////////
    bit [2:0] sw = 0;
    bit [7:0] uart_stim_data;  
    ///////////////////////////////////////////////////////////////////////////////
    // Declaration of Sequence utils
    //////////////////////////////////////////////////////////////////////////////
    `uvm_object_utils(uart_write_seq)
    ///////////////////////////////////////////////////////////////////////////////
    // Method name : new
    // Description : sequence constructor
    //////////////////////////////////////////////////////////////////////////////
    function new(string name = "uart_write_seq");
        super.new(name);
    endfunction
    ///////////////////////////////////////////////////////////////////////////////
    // Method name : body 
    // Description : Body of sequence to send randomized transaction through
    // sequencer to driver
    //////////////////////////////////////////////////////////////////////////////
    virtual task body();

        req = uart_transaction::type_id::create("req");
        wait_for_grant();
        req.sw = sw;
        req.uart_stim_data = uart_stim_data;
        `uvm_info(get_full_name(),$sformatf("UART STIM TRANSACTION, data is : %h , speed is :%h",uart_stim_data ,sw),UVM_LOW);
        send_request(req);
        wait_for_item_done();
    endtask
   
endclass

`endif