class ahb_base_test extends uvm_test;
  `uvm_component_utils(ahb_base_test);

  ahb_env env_h;
 
  ahb_env_config env_config_h;

  function new(string name="ahb_base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    env_config_h = ahb_env_config::type_id::create("env_config_h");
    env_config_h.master_cfg = ahb_agent_config::type_id::create("master_cfg");
    env_config_h.slave_cfg = ahb_agent_config::type_id::create("slave_cfg");

    if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_vif",env_config_h.ahb_vif))
      `uvm_fatal("AHB_BASE_TEST/NOVIF",{"virtual interface must be set for : ",get_full_name(),".vif"});

    env_config_h.has_coverage = 1;

    uvm_config_db #(ahb_env_config)::set(this,"*","ahb_env_config",env_config_h);

    env_h = ahb_env::type_id::create("env_h",this);
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name(),{get_full_name()," created.."},UVM_MEDIUM);
  endfunction : end_of_elaboration_phase

  function void init_vseq(ahb_base_vseq vseq);
    vseq.ahb_master_sqr = env_h.master_agent_h.m_sequencer;
    vseq.ahb_slave_sqr = env_h.slave_agent_h.m_sequencer;
  endfunction : init_vseq
endclass : ahb_base_test

