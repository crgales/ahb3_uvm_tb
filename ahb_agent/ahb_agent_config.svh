class ahb_agent_config extends uvm_object;
  `uvm_object_utils(ahb_agent_config);

  virtual ahb_if ahb_vif;

  uvm_active_passive_enum is_active;

  function new(string name="ahb_agent_config");
    super.new(name);
  endfunction : new
endclass : ahb_agent_config