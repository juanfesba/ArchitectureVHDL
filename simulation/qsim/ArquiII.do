onerror {quit -f}
vlib work
vlog -work work ArquiII.vo
vlog -work work ArquiII.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.DATAPATH_vlg_vec_tst
vcd file -direction ArquiII.msim.vcd
vcd add -internal DATAPATH_vlg_vec_tst/*
vcd add -internal DATAPATH_vlg_vec_tst/i1/*
add wave /*
run -all
