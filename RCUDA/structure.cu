#include <stdio.h>
#include <stdlib.h>
#include "structure.h"

int *load_structure(char *filepath, int *num_matrices) {
    int i, j, id;
    FILE *file = fopen(filepath, "r");

    if (file == NULL) {
        printf("Problema ao abrir o arquivo. Verifique o caminho do arquivo, saindo...\n");
        exit(1);
    }

    if (!fscanf(file, "%d", num_matrices)) {
        printf("Problema ao ler o arquivo, saindo...\n");
        exit(1);
    }

    int *structure = (int *) malloc(9 * *num_matrices * sizeof(int));

    for (j = 0; j < *num_matrices; j++) {
        for (i = 0, id = j; i < 9; i++, id += *num_matrices){
            if (!fscanf(file, "%d", &structure[id])) {
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

void print_matrix(int *matrix) {
    int i;
    for (i = 0; i < 9; i++) {
        if (i != 0 && i % 3 == 0)
            printf("\n");
        printf("%d\t", matrix[i]);
    }
    printf("\n");
}
