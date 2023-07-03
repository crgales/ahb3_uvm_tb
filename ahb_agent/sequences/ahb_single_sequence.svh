class ahb_single_sequence extends ahb_base_sequence;
  `uvm_object_utils(ahb_single_sequence);

  function new(string name="ahb_single_sequence");
    super.new(name);
  endfunction : new

  task body();
    req = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.HBURST == SINGLE;});
    finish_item(req);
  endtask : body
endclass : ahb_single_sequence

