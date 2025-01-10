package transaction;
class FIFO_transaction;

 parameter FIFO_WIDTH = 16;
 parameter FIFO_DEPTH = 8;
 localparam max_fifo_addr = $clog2(FIFO_DEPTH);

 bit clk;
 rand logic [FIFO_WIDTH-1:0] data_in;
 rand bit rst_n, wr_en, rd_en;
 logic [FIFO_WIDTH-1:0] data_out;
 logic wr_ack, overflow;
 logic full, empty, almostfull, almostempty, underflow;

 integer WR_EN_ON_DIST=70 ,RD_EN_ON_DIST=30;

 constraint rst {
 	rst_n dist{1:/98,0:/2};
 }

 constraint wr_enable{
    wr_en dist {1:/WR_EN_ON_DIST,0:/100-WR_EN_ON_DIST};
 }

 constraint rd_enable{
    rd_en dist {1:/RD_EN_ON_DIST,0:/100-RD_EN_ON_DIST};
 }

endclass : FIFO_transaction
endpackage : transaction