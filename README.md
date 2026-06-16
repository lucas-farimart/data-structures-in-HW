# Hardware implementation of some Data Structures

Some implementations of especific data structures on dedicated hardware using SystemVerilog language.
(Algumas implementações de estruturas de dados específicas em hardware dedicado usando a linguagem SystemVerilog.)

## 1. Sparsity-Aware FIFO
The firts implementation is a Sparsity-Aware FIFO, a data structure with the ability to advance data on shifting when zeros are detected.

<img width="1255" height="711" alt="Captura de tela 2026-06-16 201050" src="https://github.com/user-attachments/assets/6cd97905-52f6-465d-94a0-0fd4bb6ee2a9" />


### Simulations 

Simulation was done with Xcelium from Cadence, and the waves on Simvision shows that some data can even reach the other end of the FIFO more quickly than without awareness. 


<img width="1507" height="771" alt="sparseFIFO_case2" src="https://github.com/user-attachments/assets/2e73c866-7d8b-459e-b717-8befe28887f6" />

<img width="1609" height="854" alt="sparseFIFO_case1" src="https://github.com/user-attachments/assets/b0a2034e-d720-4afe-be83-2d70907378cd" />
