#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "structure.h"
#include "reduction.h"

inline
cudaError_t checkCuda(cudaError_t result) {
    if (result != cudaSuccess)
        fprintf(stderr, "CUDA Runtime Error: %s\n", cudaGetErrorString(result));
    return result;
}

int main(int argc, char *argv[]) {
	int i, j, k;

    if (argc != 2) {
        printf("Uso: %s <caminho_lista_matrizes>\n", argv[0]);
        return 3;
    }

    char *filepath = argv[1];

    int num_matrices;
    int **structure_h = load_structure(filepath, &num_matrices);
	int BlockSize = 64;
	int GridSize = (num_matrices+BlockSize-1)/BlockSize;

    int *structure_d[9];
	int *result_d[9];
	int *result_h[9];
	for(i = 0; i < 9; i++)
		result_h[i] = new int[GridSize];
	
	cudaSetDevice(0);
	for(i = 0; i < 9; i ++) {
		checkCuda(cudaMalloc((void**) &structure_d[i], num_matrices * sizeof(int)));
		checkCuda(cudaMalloc((void**) &result_d[i], GridSize * sizeof(int)));

		checkCuda(cudaMemcpy(structure_d[i], structure_h[i], num_matrices * sizeof(int), cudaMemcpyHostToDevice));
		reduction<<<GridSize, BlockSize, BlockSize>>>(structure_d[i], result_d[i], num_matrices);
		checkCuda(cudaMemcpy(result_h[i], result_d[i], GridSize  * sizeof(int), cudaMemcpyDeviceToHost));
		
	}
	//cudaDeviceSynchronize();

	//for(i = 0; i < 9; i++)

	int final[3][3];

	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			int min = result_h[i*3+j][0];
			for(k = 1; k < GridSize; k++) {
				if(min > result_h[i*3+j][k]) min = result_h[i*3+j][k];
			}
			final[i][j] = min;
		}
	}

    print_matrix(final);
	
	for(i = 0; i < 9; i++) {
		free(structure_h[i]);
		delete [] result_h[i];
		checkCuda(cudaFree(structure_d[i]));
		checkCuda(cudaFree(result_d[i]));
	}
    free(structure_h);

    return EXIT_SUCCESS;
}
