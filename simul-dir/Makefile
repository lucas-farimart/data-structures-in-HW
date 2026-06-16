#========================================================
#                   VARIAVEIS DE CONFIG
#========================================================
SRCS       = -f rtl.lst
TOP        = tb_neurons
BUILD_DIR  = xcelium.d
WAVE_DIR   = waves
XRUN       = xrun
XRUN_FLAGS = -sv -64 -access +rwc -timescale 1ns/1ns
WAVE_FLAGS = -input waves.tcl # ainda nao existe 

# Alvo padrao
all: help

#========================================================
#                 COMANDOS DE SIMULACAO
#========================================================
help:
	@echo "" 
	@echo "|---------------------------------------------|" 
	@echo "|     Data Strucuture studies for Hardware    |"
	@echo "|---------------------------------------------|"
	@echo "| Spare-aware FIFO       | sparse-fifo        |"
	@echo "| Future work            |                    |"
	@echo "|------------------------|--------------------|"
	@echo "" 

sparse-fifo:
	clear
	@echo "Running Sparse FIFO (GUI)..."
	$(XRUN) $(XRUN_FLAGS) \
	../rtl-codes/sparse_shift_buff.sv ../test-benches/tb_sparseFIFO.sv \
	-top tb_sparseFIFO -gui 

#========================================================
#                COMANDOS UTEIS EXTRAS
#========================================================

debug:
	@mkdir -p $(WAVE_DIR)
	$(XRUN) $(XRUN_FLAGS) $(SRCS) -top $(TOP) -messages -linedebug -access +rwc $(WAVE_FLAGS)

clean:
	rm -rf $(BUILD_DIR) *.log *.history $(WAVE_DIR) *.shm

erros:
	rm -f erros.log
	grep "*E" xrun.log >> erros.log
	vim erros.log

rebuild: clean run