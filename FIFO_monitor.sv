import coverage::*;
import scoreboard::*;
import transaction::*;
import shared_pkg::*;

module FIFO_monitor(FIFO_if.MONITOR fifo_if);

	FIFO_transaction tr;
	FIFO_coverage cvr;
	FIFO_scoreboard sb;	

	initial begin

		tr=new();
		cvr=new();
		sb=new();
		
		forever begin
			@(negedge fifo_if.clk);
			tr.data_out=fifo_if.data_out;
			tr.wr_ack=fifo_if.wr_ack;
			tr.overflow=fifo_if.overflow;
			tr.full=fifo_if.full;
			tr.empty=fifo_if.empty;
			tr.almostfull=fifo_if.almostfull;
			tr.almostempty=fifo_if.almostempty;
			tr.underflow=fifo_if.underflow;
			tr.wr_en=fifo_if.wr_en;
			tr.rd_en=fifo_if.rd_en;
			tr.rst_n=fifo_if.rst_n;
			tr.data_in=fifo_if.data_in;
			tr.clk=fifo_if.clk;
			sb.count=DUT.count;
			sb.mem=DUT.mem;
			sb.w_count=DUT.wr_ptr;
			sb.r_count=DUT.rd_ptr;			

			fork
				begin
					cvr.sample_data(tr);
				end
				begin
					sb.check_data(tr);
				end
			join
			if(test_finished==1)
				begin
					$display("error count=%d and correct count=%d",error_count,correct_count);
					$stop;
				end
		end
	end
endmodule : FIFO_monitor