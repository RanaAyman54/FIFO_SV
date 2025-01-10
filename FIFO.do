vlib work
vlog  shared_pkg.sv FIFO_transaction.sv FIFO_scoreboard.sv FIFO_coverage.sv FIFO_top.sv  FIFO_if.sv FIFO.sv FIFO_tb.sv  FIFO_monitor.sv FIFO_sva.sv  +cover
vsim -voptargs=+acc work.FIFO_top -cover
add wave *
coverage save FIFO_test.ucdb -onexit
run -all
vcover report FIFO_test.ucdb -details -all -annotate -output FIFO_cvr.txt
