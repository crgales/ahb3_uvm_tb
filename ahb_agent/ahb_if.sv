interface ahb_if(input bit HCLK, input bit HRESETn);
 logic     HREADY;
 logic     HWRITE;
 logic [1:0]  HRESP;
 logic [1:0]  HTRANS;
 logic [2:0]   HBURST;
 logic [2:0]   HSIZE;
 logic [31:0]  HADDR;
 logic [31:0]  HWDATA;
 logic [31:0]  HRDATA;

  clocking mst_drv_cb @(posedge HCLK);
    default input #1 output #0;
    input HRESETn, HRESP, HREADY, HRDATA;
    output HTRANS, HBURST, HSIZE, HADDR, HWDATA, HWRITE;
  endclocking 

  clocking mon_cb @(posedge HCLK);
    default input #1 output #0;
    input HRESETn, HREADY, HRESP, HTRANS, HBURST, HSIZE, HADDR, HWDATA, HRDATA, HWRITE;
  endclocking

  clocking slv_drv_cb @(posedge HCLK);
    default input #1 output #0;
    input HRESETn, HTRANS, HBURST, HSIZE, HADDR, HWDATA, HWRITE;
    output HRESP, HREADY;
    output HRDATA;
  endclocking

endinterface : ahb_if
