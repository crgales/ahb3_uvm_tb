class ahb_monitor extends uvm_monitor;
  `uvm_component_utils(ahb_monitor);

  ahb_transaction req;

  virtual ahb_if vif;
  ahb_agent_config cfg;

  uvm_analysis_port #(ahb_transaction) monitor_ap;

  function new(string name="ahb_monitor",uvm_component parent=null);
    super.new(name,parent);
    monitor_ap = new("monitor_ap",this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(  ahb_agent_config)::get(this,"","ahb_agent_config",cfg))
      `uvm_fatal(get_name(),{"configuration must be set for : ",get_full_name(),".cfg"});
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    vif = cfg.ahb_vif;
  endfunction : connect_phase

    function void end_of_elaboration_phase(uvm_phase phase);
      `uvm_info(get_name(),{get_full_name()," created..."},UVM_MEDIUM);
    endfunction : end_of_elaboration_phase

    task run_phase(uvm_phase phase);
      //phase.raise_objection(this,"starting master monitor");
    forever begin
      do @(vif.mon_cb);
      while(!vif.mon_cb.HRESETn);
      //`uvm_info("  ahb_MONITOR","RESET deasserted .. ",UVM_MEDIUM);
      //`uvm_info("  ahb_MONITOR","Master monitoring...",UVM_MEDIUM);
      monitor();
    end
      //phase.drop_objection(this,"ending master monitor");
  endtask : run_phase

  function ahb_transaction create_transaction();
    ahb_transaction req = ahb_transaction::type_id::create("req");
    req.HADDR = new[1];
    req.HTRANS = new[1];
    req.HWDATA = new[1];
    return req;
  endfunction : create_transaction

  task monitor();
    req = create_transaction();
    @(vif.mon_cb);
    if(vif.mon_cb.HTRANS == IDLE) begin
      `uvm_info("  ahb_MONITOR","IDLE transaction detected",UVM_MEDIUM);
      req.HADDR[0] = vif.mon_cb.HADDR;
      $cast(req.HTRANS[0],vif.mon_cb.HTRANS);
      $cast(req.HBURST,vif.mon_cb.HBURST);
      $cast(req.HWRITE,vif.mon_cb.HWRITE);
      $cast(req.HSIZE,vif.mon_cb.HSIZE);
      monitor_ap.write(req);
      //return;
    end
    
    if(vif.mon_cb.HTRANS == BUSY) begin
      `uvm_info("  ahb_MONITOR","BUSY Transaction detected",UVM_MEDIUM);
      req.HADDR[0] = vif.mon_cb.HADDR;
      $cast(req.HTRANS[0],vif.mon_cb.HTRANS);
      $cast(req.HBURST,vif.mon_cb.HBURST);
      $cast(req.HWRITE,vif.mon_cb.HWRITE);
      $cast(req.HSIZE,vif.mon_cb.HSIZE);
      monitor_ap.write(req);
      @(vif.mon_cb);
      if(vif.mon_cb.HTRANS == IDLE) begin  
        `uvm_info("  ahb_MONITOR","IDLE Transaction detected",UVM_MEDIUM);
        req.HADDR[0] = vif.mon_cb.HADDR;
        $cast(req.HTRANS[0],vif.mon_cb.HTRANS);
        $cast(req.HBURST,vif.mon_cb.HBURST);
        $cast(req.HWRITE,vif.mon_cb.HWRITE);
        $cast(req.HSIZE,vif.mon_cb.HSIZE);
        monitor_ap.write(req);
        //return;
      end
    end
    
    if(vif.mon_cb.HTRANS == SEQ || vif.mon_cb.HTRANS == NONSEQ) begin
      `uvm_info("  ahb_MONITOR","Transaction detected",UVM_MEDIUM);
      req.HADDR[0] = vif.mon_cb.HADDR;
      $cast(req.HTRANS[0],vif.mon_cb.HTRANS);
      $cast(req.HBURST,vif.mon_cb.HBURST);
      $cast(req.HWRITE,vif.mon_cb.HWRITE);
      $cast(req.HSIZE,vif.mon_cb.HSIZE);
      req.HWDATA[0] = vif.mon_cb.HWDATA;
      //req.print();
      monitor_ap.write(req);
      //return;
    end
  endtask : monitor
endclass :   ahb_monitor

