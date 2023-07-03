class ahb_env_config extends uvm_object;
  `uvm_object_utils(ahb_env_config);

  bit has_coverage;

  ahb_agent_config master_cfg;
  ahb_agent_config slave_cfg;

  virtual ahb_if ahb_vif;

  function new(string name="ahb_env_config");
    super.new(name);
  endfunction : new
endclass : ahb_env_config

