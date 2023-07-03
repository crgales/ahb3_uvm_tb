class ahb_wrap_sequence extends ahb_base_sequence;
  `uvm_object_utils(ahb_wrap_sequence);

  function new(string name="ahb_wrap_sequence");
    super.new(name);
  endfunction : new

  task body();
    req = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.HBURST == WRAP4 || req.HBURST == WRAP8 || req.HBURST == WRAP16;});
    finish_item(req);
  endtask : body
endclass : ahb_wrap_sequence
