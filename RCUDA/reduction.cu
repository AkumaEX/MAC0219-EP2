#include <stdio.h>
#include "reduction.h"

__global__ void reduction(int *structure, int num_matrices, int task_size, int *result) {

    extern __shared__ int sdata[];  // guarda o minimo que uma thread consegue encontrar
    int tid = threadIdx.x;
    int bid = blockIdx.x;

    int start = (tid * task_size) + (num_matrices * bid);  // indice da estrutura que a thread comeca trabalhar
    int finish = (start + task_size < num_matrices * (bid + 1)) ? start + task_size : num_matrices * (bid + 1); // indice da estrutura onde a thread precisa parar

    sdata[tid] = structure[start]; // o menor elemento inicial e o primeiro elemento
    __syncthreads();

    int i; // cada thread percorre os elementos e vai guardando o minimo no indice da sua thread
    for (i = start + 1; i < finish; i++)
        sdata[tid] = sdata[tid] ^ ((structure[i] ^ sdata[tid]) & -(structure[i] < sdata[tid]));
    __syncthreads();

    if (tid == 0) { // a thread zero sozinha percorre todos os elementos minimos e devolve o menor deles
        for (i = 1; i < blockDim.x; i++)
            sdata[0] = sdata[0] ^ ((sdata[i] ^ sdata[0]) & -(sdata[i] < sdata[0]));
        result[bid] = sdata[0];
    }
}