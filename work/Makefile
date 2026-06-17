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
	@echo "| DCL Buffer             | dcl-buff           |"
	@echo "| Future work            \                    |"
	@echo "|------------------------|--------------------|"
	@echo "" 

sparse-fifo:
	clear
	@echo "Running Sparse FIFO (GUI)..."
	$(XRUN) $(XRUN_FLAGS) \
	../sparse-fifo/sparse_shift_buff.sv ../sparse-fifo/tb_sparseFIFO.sv \
	-top tb_sparseFIFO -gui 

dcl-buff:
	clear
	@echo "Running Doubly Circular Linked Buffer (DCLB)..."
	$(XRUN) $(XRUN_FLAGS) \
	../dclb/dcl_buffer.sv ../dclb/tb_dclb.sv \
	-top tb_dclb -gui 

#========================================================
#                COMANDOS UTEIS EXTRAS
#========================================================
clean:
	rm -rf $(BUILD_DIR) *.log *.history $(WAVE_DIR) *.shm

erros:
	rm -f erros.log
	grep "*E" xrun.log >> erros.log
	vim erros.log

rebuild: clean run