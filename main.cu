#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "structure.h"
#include "reduction.h"

#define GRIDDIM 9
#define BLOCKDIM 64

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Uso: %s <caminho_lista_matrizes>\n", argv[0]);
        return 3;
    }

    char *filepath = argv[1];

    int num_matrices;
    int *structure_h = load_structure(filepath, &num_matrices);
    int *structure_d;
    int result_h[9];
    int *result_d;
    int num_threads = (int) ceil(num_matrices / 2);
    int block_dim = (num_threads > BLOCKDIM) ? BLOCKDIM : num_threads;
    int task_size = (int) ceil(num_matrices / block_dim); // numero de elementos que a thread precisa comparar
    printf("num_threads: %d, block_dim: %d, task_size: %d\n", num_threads, block_dim, task_size);
    cudaMalloc((void**) &structure_d, 9 * num_matrices * sizeof(int));
    cudaMalloc((void**) &result_d, 9 * sizeof(int));

    cudaMemcpy(structure_d, structure_h, 9 * num_matrices * sizeof(int), cudaMemcpyHostToDevice);
    reduction<<<GRIDDIM, block_dim, block_dim>>>(structure_d, num_matrices, task_size, result_d);
    cudaMemcpy(result_h, result_d, 9 * sizeof(int), cudaMemcpyDeviceToHost);

    print_matrix(result_h);

    free(structure_h);
    cudaFree(structure_d);
    cudaFree(result_d);

    return EXIT_SUCCESS;
}