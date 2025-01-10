package scoreboard;

	import transaction::*;
    import shared_pkg::*;

	class FIFO_scoreboard;

		parameter FIFO_W = 16;
        parameter FIFO_D = 8;

        localparam max_fifo_addr = $clog2(FIFO_D);


		logic [FIFO_W-1:0] data_out_ref;
        logic wr_ack_ref, overflow_ref,full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref;

        logic [FIFO_W-1:0]mem[FIFO_D-1:0];
        logic [max_fifo_addr-1:0]w_count,r_count;
        logic [max_fifo_addr:0]count;

       
        task check_data( input FIFO_transaction F_t);
        	reference_model(F_t);
        	if(F_t.data_out===data_out_ref && /*F_t.wr_ack===wr_ack_ref &&/* F_t.overflow===overflow_ref && */F_t.full===full_ref && F_t.empty===empty_ref && F_t.almostfull===almostfull_ref && F_t.almostempty===almostempty_ref /*&& F_t.underflow===underflow_ref*/)
             begin 
             	correct_count++;
                 
             end
             else begin
             	error_count++;
             	$display("error no.=%d ",error_count);
             end
        endtask  : check_data 

        task reference_model (input FIFO_transaction F_ref) ;
          fork
          	begin
          		
          		if (!F_ref.rst_n) begin
		        w_count <= 0;
	            end
	            else if (F_ref.wr_en && count<FIFO_D) begin
		         mem[w_count] <= F_ref.data_in;
		         wr_ack_ref <= 1;
		         w_count <= w_count +1;
	             end
	            else begin 
		           wr_ack_ref <= 0; 
		           if (full_ref && F_ref.wr_en) 
			        overflow_ref <= 1;
		           else 
			        overflow_ref <= 0;
	            end
	            
          	end

          	begin
        
          		if (!F_ref.rst_n) begin
		         r_count <= 0;
	            end
	            else if (F_ref.rd_en && count!=0) begin
		         data_out_ref <= mem[r_count];
		         r_count <= r_count + 1;
	            end
	            else if(F_ref.rd_en && empty_ref) 
	            	
	            		underflow_ref<=1;
	            else
	            		underflow_ref<=0;
	            
	            
          	end

          	begin
          		 if (!F_ref.rst_n) begin
		         count <= 0;	         
	            end
	            else begin
			    case ( {F_ref.wr_en, F_ref.rd_en})
			     2'b10: if(!full_ref) count<=count+1;
			     2'b01: if(!empty_ref) count<=count-1;
			  	default : count<=count;
			  endcase
	            end
          	end
          	
          join

                full_ref = (count == FIFO_D )? 1 : 0;
          		almostfull_ref = (count == FIFO_D-1 )? 1 : 0;
          		empty_ref = (count == 0)? 1 : 0;
          		almostempty_ref = (count == 1)? 1 : 0;

        endtask : reference_model
    



	endclass : FIFO_scoreboard

endpackage 