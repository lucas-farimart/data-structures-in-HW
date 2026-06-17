# Sparsity-Aware FIFO

This implementation is a Sparsity-Aware FIFO, a data structure with the ability to advance shifting data when zeros are detected.

<img width="941" height="533" alt="Captura de tela 2026-06-16 201050" src="https://github.com/user-attachments/assets/6cd97905-52f6-465d-94a0-0fd4bb6ee2a9" />

## Simulations 

Simulation were done with Xcelium from Cadence, and the waves on Simvision shows that some data can even reach the other end of the FIFO more quickly than without sparsity awareness. 

Caso 1:
<img width="969" height="484" alt="sparseFIFO_case1" src="https://github.com/user-attachments/assets/67eac81e-8c25-4245-94e3-a98604db70c9" />

Caso 2:
<img width="969" height="484" alt="sparseFIFO_case2" src="https://github.com/user-attachments/assets/2e73c866-7d8b-459e-b717-8befe28887f6" />
