class ahb_idle_sequence extends ahb_base_sequence;
  `uvm_object_utils(ahb_idle_sequence);

  function new(string name="ahb_idle_sequence");
    super.new(name);
  endfunction : new

  task body();
    req = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {req.HBURST == SINGLE;req.HTRANS[0] == IDLE;});
    finish_item(req);
  endtask : body
endclass : ahb_idle_sequence

