MODE=puresim

VLOG = vlog
VOPT = vopt
VSIM = vsim

UVM_TESTNAME ?= ahb_simple_test

all: hdl_comp hvl_comp opt sim

hdl_comp:
	${VLOG} ../ahb_agent/ahb_agent_pkg.sv ../ahb_agent/ahb_if.sv
	${VLOG} ../env/ahb_env_pkg.sv
	${VLOG} ../test/ahb_test_pkg.sv
	${VLOG} top.sv

hvl_comp:

opt:
	${VOPT} -o top_opt top +designfile -debug

sim:
	${VSIM} -c top_opt +qwavedb=+signal+class +UVM_TESTNAME=${UVM_TESTNAME} -do "run -all; quit"

clean:
	rm -rf work modelsim.ini design.bin qwave.db