#include <stdio.h>
#include <stdlib.h>
#include "structure.h"

int **load_structure(char *filepath, int *num_matrices) {
    int i, j;
    FILE *file = fopen(filepath, "r");

    if (file == NULL) {
        printf("Problema ao abrir o arquivo. Verifique o caminho do arquivo, saindo...\n");
        exit(1);
    }

    if (!fscanf(file, "%d", num_matrices)) {
        printf("Problema ao ler o arquivo, saindo...\n");
        exit(1);
    }

    int **structure = (int **) malloc(9 * sizeof(int*));
	for(i = 0; i < 9; i++)
		structure[i] = (int*)malloc(sizeof(int) * *num_matrices);

    for (i = 0; i < *num_matrices; i++) {
        for (j = 0; j < 9; j++){
            if (!fscanf(file, "%d", &structure[j][i])) {
                printf("Problema ao ler o arquivo, saindo...\n");
                exit(1);
            }
        }
    }

    fclose(file);
    return structure;
}

void print_structure(int *structure, int num_matrices) {
    int i;
    for (i = 0; i < 9 * num_matrices; i++) {
        if (i != 0 && i % num_matrices == 0)
            printf("\n");
        printf("%d\t", structure[i]);
    }
    printf("\n");
}

void print_matrix(int matrix[][3]) {
    int i, j;
    for (i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			printf("%d\t", matrix[i][j]);
		}
		printf("\n");
    }
    printf("\n");
}
