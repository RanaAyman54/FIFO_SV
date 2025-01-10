import shared_pkg::*;
import transaction::*;

module FIFO_tb(FIFO_if.TEST fifo_if);
	FIFO_transaction tr;

	initial begin
		tr=new();
		fifo_if.data_in=0;
		fifo_if.wr_en=0;
		fifo_if.rd_en=0;
		fifo_if.rst_n=1;

         tr.constraint_mode(0);
		repeat(100000)begin
			@(negedge fifo_if.clk);
			assert(tr.randomize())
			fifo_if.data_in=tr.data_in;
			fifo_if.wr_en=tr.wr_en;
			fifo_if.rd_en=tr.rd_en;
			fifo_if.rst_n=tr.rst_n;
		end

         tr.constraint_mode(1);
		repeat(100000)begin
			@(negedge fifo_if.clk);
			assert(tr.randomize())
			fifo_if.data_in=tr.data_in;
			fifo_if.wr_en=tr.wr_en;
			fifo_if.rd_en=tr.rd_en;
			fifo_if.rst_n=tr.rst_n;
		end

       
		repeat(100000)begin
			@(negedge fifo_if.clk);
			assert(tr.randomize())
			fifo_if.data_in=tr.data_in;
			fifo_if.wr_en=1;
			fifo_if.rd_en=tr.rd_en;
			fifo_if.rst_n=1;
		end

		 
		repeat(100000)begin
			@(negedge fifo_if.clk);
			assert(tr.randomize())
			fifo_if.data_in=tr.data_in;
			fifo_if.wr_en=tr.wr_en;
			fifo_if.rd_en=tr.rd_en;
			fifo_if.rst_n=tr.rst_n;
		end

		
		repeat(100000)begin
			@(negedge fifo_if.clk);
			assert(tr.randomize())
			fifo_if.data_in=tr.data_in;
			fifo_if.wr_en=tr.wr_en;
			fifo_if.rd_en=1;
			fifo_if.rst_n=1;
		end

		test_finished=1;

	end
endmodule : FIFO_tb