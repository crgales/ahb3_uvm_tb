class ahb_undeflen_sequence extends ahb_base_sequence;
  `uvm_object_utils(ahb_undeflen_sequence);

  function new(string name="ahb_undeflen_sequence");
    super.new(name);
  endfunction : new

  task body();
    req = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.HBURST == INCR;req.HADDR.size() < 20;});
    finish_item(req);
endtask : body

endclass : ahb_undeflen_sequence