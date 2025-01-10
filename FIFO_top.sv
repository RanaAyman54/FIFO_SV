module FIFO_top;

bit clk;

always #1 clk=~clk;

FIFO_if fifo_if (clk);
FIFO DUT (fifo_if);
FIFO_tb TEST (fifo_if);
FIFO_monitor MONITOR (fifo_if);
FIFO_sva SVA (fifo_if);
endmodule : FIFO_top