class ahb_base_vseq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(ahb_base_vseq);

  ahb_sequencer ahb_master_sqr;
  ahb_sequencer ahb_slave_sqr;

  function new(string name="ahb_base_vseq");
    super.new(name);
  endfunction : new

endclass : ahb_base_vseq
