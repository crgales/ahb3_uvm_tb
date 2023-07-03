class ahb_coverage extends uvm_subscriber #(ahb_transaction);
  `uvm_component_utils(ahb_coverage);

  ahb_transaction tx;

  covergroup ahb_cg;
    ahb_addr_cp  : coverpoint tx.HADDR[0];
    ahb_rw_cp  : coverpoint tx.HWRITE;
    ahb_size_cp  : coverpoint tx.HSIZE {bins size_bins = { BYTE, HALFWORD, WORD, WORDx2 }; }
    ahb_burst_cp  : coverpoint tx.HBURST;
    ahb_wdata_cp  : coverpoint tx.HWDATA[0];
    ahb_trans_cp  : coverpoint tx.HTRANS[0];
  endgroup : ahb_cg
  
  function new(string name="ahb_coverage",uvm_component parent=null);
    super.new(name,parent);
    ahb_cg = new();
  endfunction : new

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name(),{get_full_name()," created.. "},UVM_MEDIUM);
  endfunction : end_of_elaboration_phase

  function void write(ahb_transaction t);
    tx = t;
    ahb_cg.sample();
  endfunction : write
endclass : ahb_coverage


