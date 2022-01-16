`ifndef uart_driver
`define uart_driver

class uart_driver extends uvm_driver #(uart_transaction);
 
    //////////////////////////////////////////////////////////////////////////////
    // Declaration of transaction item 
    //////////////////////////////////////////////////////////////////////////////
        uart_transaction trans;
    //////////////////////////////////////////////////////////////////////////////
    // Declaration of Virtual interface 
    //////////////////////////////////////////////////////////////////////////////
        virtual uart_interface vif;
    //////////////////////////////////////////////////////////////////////////////
    // Declaration of component utils to register with factory 
    //////////////////////////////////////////////////////////////////////////////
    `uvm_component_utils(uart_driver)
    //////////////////////////////////////////////////////////////////////////////
    // Method name : new 
    // Description : constructor 
    //////////////////////////////////////////////////////////////////////////////
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    //////////////////////////////////////////////////////////////////////////////
    // Declaration of variables
    //////////////////////////////////////////////////////////////////////////////
    integer baud_clock_cycles;// number of clock to wait for uart baud
    integer num_of_sample = 16;
    integer baud9600 = 651;
    integer baud19200 = 325;
    integer baud38400 = 163;
    integer baud57600 = 109;
    integer baud115200 = 54;
    //////////////////////////////////////////////////////////////////////////////
    // Method name : build_phase 
    // Description : construct the components 
    //////////////////////////////////////////////////////////////////////////////
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
            if(!uvm_config_db#(virtual uart_interface)::get(this, "", "vif", vif))
                `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction: build_phase
    //////////////////////////////////////////////////////////////////////////////
    // Method name : run_phase 
    // Description : Drive the transaction info to DUT
    //////////////////////////////////////////////////////////////////////////////
    virtual task run_phase(uvm_phase phase);
      vif.rx_din = 1;
      vif.sw = 0;
      forever begin
      seq_item_port.get_next_item(req);
      @(posedge vif.clock);
      drive();
      seq_item_port.item_done();
      end
    endtask : run_phase
    //////////////////////////////////////////////////////////////////////////////
    // Method name : drive 
    // Description : Driving the dut inputs
    //////////////////////////////////////////////////////////////////////////////
    task drive();
        vif.sw = req.sw;

        if (req.sw == 0)
            baud_clock_cycles = baud9600*num_of_sample;
        else if (req.sw == 1)
            baud_clock_cycles = baud19200*num_of_sample;
        else if (req.sw == 2)
            baud_clock_cycles = baud38400*num_of_sample;
        else if (req.sw == 3)
            baud_clock_cycles = baud57600*num_of_sample;
        else if (req.sw == 4)
            baud_clock_cycles = baud115200*num_of_sample;
        else
            baud_clock_cycles = baud9600*num_of_sample;

        vif.rx_din = 0;
        repeat(baud_clock_cycles)
            @(posedge vif.clock);
            
        for ( int i = 0; i < 8; i++) begin
            vif.rx_din = req.uart_stim_data[i];
            repeat(baud_clock_cycles)
                @(posedge vif.clock);
        end
        
        vif.rx_din = 1;
        repeat(baud_clock_cycles)
            @(posedge vif.clock);
            
    endtask

endclass : uart_driver

`endif





