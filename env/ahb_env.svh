class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env);

  ahb_env_config env_config_h;

  ahb_agent master_agent_h;
  ahb_agent slave_agent_h;

  ahb_coverage cov_h;

  function new(string name="ahb_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(ahb_env_config)::get(this,"","ahb_env_config",env_config_h))
      `uvm_fatal("AHB_ENV/NOCONFIG",{"Configuation not set for : ",get_full_name(),".cfg"});

    env_config_h.master_cfg.ahb_vif = env_config_h.ahb_vif;
    env_config_h.slave_cfg.ahb_vif = env_config_h.ahb_vif;

    env_config_h.master_cfg.is_active = UVM_ACTIVE;
    env_config_h.slave_cfg.is_active = UVM_ACTIVE;

    uvm_config_db #(ahb_agent_config)::set(this,"*master*","ahb_agent_config",env_config_h.master_cfg);
    uvm_config_db #(ahb_agent_config)::set(this,"*slave*","ahb_agent_config",env_config_h.slave_cfg);

    master_agent_h = ahb_agent::type_id::create("master_agent_h",this);
    slave_agent_h = ahb_agent::type_id::create("slave_agent_h",this);

    if (env_config_h.has_coverage)
      cov_h = ahb_coverage::type_id::create("cov_h",this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if (env_config_h.has_coverage) begin
      master_agent_h.agent_ap.connect(cov_h.analysis_export);
      //slave_agent_h.agent_ap.connect(cov_h.analysis_export);
    end
  endfunction : connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("AHB_ENV",{get_full_name()," created..."},UVM_MEDIUM);
  endfunction : end_of_elaboration_phase

endclass : ahb_env
