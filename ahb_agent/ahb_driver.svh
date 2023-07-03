class ahb_driver extends uvm_driver #(ahb_transaction);
  `uvm_component_utils(ahb_driver);

  ahb_agent_config m_config;
  virtual ahb_if.master_drv ahb_vif;

  function new(string name="ahb_driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  function void   build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",m_config))
      `uvm_fatal("NOCOFIG",{"Configuration must be set for : " ,get_full_name(),".m_config"});
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    ahb_vif = m_config.ahb_vif;
  endfunction : connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_name(),{get_full_name()," Created.."},UVM_MEDIUM);
  endfunction : end_of_elaboration_phase

  task run_phase(uvm_phase phase);
    //phase.raise_objection(this,"starting driver");
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
    //phase.raise_objection(this,"ending driver");
  endtask : run_phase

  task drive();
    int j;
    do
      @(ahb_vif.mst_drv_cb);
    while(!ahb_vif.HRESETn);
    void'(req.add_busy_cycles());
    ahb_vif.mst_drv_cb.HWRITE <= req.HWRITE;
    ahb_vif.mst_drv_cb.HSIZE <= req.HSIZE;
    ahb_vif.mst_drv_cb.HBURST <= req.HBURST;
    foreach(req.HTRANS[i]) begin
      ahb_vif.mst_drv_cb.HTRANS <= req.HTRANS[i];
      if(req.HTRANS[i] != BUSY) begin
        ahb_vif.mst_drv_cb.HADDR <= req.HADDR[j];
        ahb_vif.mst_drv_cb.HWDATA <= req.HWDATA[j];
        j++;
      end
      else begin
        ahb_vif.mst_drv_cb.HADDR <= req.HADDR[j];
        ahb_vif.mst_drv_cb.HWDATA <= req.HWDATA[j];
      end
      do @(ahb_vif.mst_drv_cb);
      while(!ahb_vif.mst_drv_cb.HREADY);
    end
  endtask : drive
endclass :   ahb_driver
