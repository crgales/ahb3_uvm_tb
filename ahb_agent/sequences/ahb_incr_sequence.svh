class ahb_incr_sequence extends ahb_base_sequence;
  `uvm_object_utils(ahb_incr_sequence);

  function new(string name="ahb_incr_sequence");
    super.new(name);
  endfunction : new

  task body();
    req = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.HBURST == INCR4 || req.HBURST == INCR8 || req.HBURST == INCR16;});
    finish_item(req);
  endtask : body
endclass : ahb_incr_sequence

