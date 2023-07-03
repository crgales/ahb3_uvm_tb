class ahb_agent extends uvm_agent;
`uvm_component_utils(ahb_agent);

 uvm_analysis_port #(ahb_transaction) agent_ap;

 ahb_driver m_driver;
 ahb_monitor m_monitor;
 ahb_sequencer m_sequencer;

 ahb_agent_config m_config;

  function new(string name="ahb_agent",uvm_component parent=null);
    super.new(name,parent);
    agent_ap = new("agent_ap",this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(ahb_agent_config)::get(this,"ahb_agent","ahb_agent_config",m_config))
      `uvm_fatal(get_name(),{"unable to retrieve configuration for : ",get_full_name(),".cfg"});
   
    if(m_config.is_active == UVM_ACTIVE) begin
      m_driver = ahb_driver::type_id::create("m_driver",this);
      m_sequencer = ahb_sequencer::type_id::create("m_sequencer",this);
    end
    m_monitor = ahb_monitor::type_id::create("m_monitor",this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_monitor.monitor_ap.connect(agent_ap);
  endfunction : connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("AHB_AGENT",{get_full_name()," created...."},UVM_NONE);
  endfunction : end_of_elaboration_phase

endclass : ahb_agent

