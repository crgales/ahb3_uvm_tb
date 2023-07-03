class ahb_simple_test extends ahb_base_test;
  `uvm_component_utils(ahb_simple_test);

  function new(string name="ahb_simple_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    ahb_vseq vseq = ahb_vseq::type_id::create("ahb_vseq");
    phase.raise_objection(this,"starting virtual sequence");
    `uvm_info("AHB_VSEQ","Starting the test",UVM_MEDIUM);
    uvm_top.print_topology();
    vseq.start(null);
    phase.drop_objection(this,"ending virtual sequence");
  
    `uvm_info("AHB_VSEQ","Ending the test",UVM_MEDIUM);
  endtask : run_phase
endclass : ahb_simple_test

