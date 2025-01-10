package coverage;

import transaction::*;

class FIFO_coverage;
  FIFO_transaction F_cvg_txn =new();


  covergroup cg;
    w_en: coverpoint F_cvg_txn.wr_en{option.weight = 0;}
    r_en: coverpoint F_cvg_txn.rd_en{option.weight = 0;}
    w_ack: coverpoint F_cvg_txn.wr_ack{option.weight = 0;}
    overFlow: coverpoint F_cvg_txn.overflow{option.weight = 0;}
    Full: coverpoint F_cvg_txn.full{option.weight = 0;}
    Empty: coverpoint F_cvg_txn.empty{option.weight = 0;}
    almostFull: coverpoint F_cvg_txn.almostfull{option.weight = 0;}
    almostEmpty: coverpoint F_cvg_txn.almostempty{option.weight = 0;}
    underFlow: coverpoint F_cvg_txn.underflow{option.weight = 0;}

    c_w_ack:cross w_en,r_en,w_ack;
    c_overFlow:cross w_en ,r_en,overFlow;
    c_Full:cross w_en,r_en,Full;
    c_Empty:cross w_en,r_en,Empty;
    c_almostFull:cross w_en,r_en,almostFull;
    c_almostEmpty:cross w_en,r_en,almostEmpty;
    c_underFlow:cross w_en,r_en,underFlow;

  endgroup : cg

  function sample_data (input FIFO_transaction F_txn);
    F_cvg_txn=F_txn;
    cg.sample();
  endfunction : sample_data

  function new();
    cg=new();
  endfunction
 
endclass 
endpackage 