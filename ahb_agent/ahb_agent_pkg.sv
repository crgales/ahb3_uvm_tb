package ahb_agent_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  typedef enum bit [1:0] {IDLE, BUSY, NONSEQ, SEQ} transfer_t;
  typedef enum bit {READ,WRITE} rw_t;
  typedef enum bit [2:0] {SINGLE, INCR, WRAP4, INCR4, WRAP8, INCR8, WRAP16, INCR16} burst_t;
  typedef enum bit [2:0] {BYTE, HALFWORD, WORD, WORDx2, WORDx4, WORDx8, WORDx16, WORDx32} size_t;
  typedef enum bit [1:0] {OKAY, ERROR, RETRY, SPLIT} response_t;

  `include "ahb_transaction.svh"
  `include "ahb_agent_config.svh"
  `include "ahb_driver.svh"
  `include "ahb_monitor.svh"
  typedef uvm_sequencer#(ahb_transaction) ahb_sequencer;
  `include "ahb_agent.svh"

  // Sequences
  `include "sequences/ahb_base_sequence.svh"
  `include "sequences/ahb_idle_sequence.svh"
  `include "sequences/ahb_incr_sequence.svh"
  `include "sequences/ahb_single_sequence.svh"
  `include "sequences/ahb_undeflen_sequence.svh"
  `include "sequences/ahb_wrap_sequence.svh"        
endpackage