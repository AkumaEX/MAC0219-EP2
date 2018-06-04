#include <stdio.h>
#include <stdlib.h>


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

    // criamos a estrutura de 9 x numero de matrizes
    int **structure = (int **) malloc(9 * sizeof(int*));
    for (i = 0; i < 9; i++)
        structure[i] = (int *) malloc(*num_matrices * sizeof(int));


    for (j = 0; j < *num_matrices; j++) {
        for (i = 0; i < 9; i++){
            if (!fscanf(file, "%d", &structure[i][j])) {
                printf("Problema ao ler o arquivo, saindo...\n");
                exit(1);
            }
        }
    }

    fclose(file);
    return structure;
}

void destroy_structure(int **structure) {
    int i;
    for (i = 0; i < 9; i++)
        free(structure[i]);
    free(structure);
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

int get_min(int *array, int array_size) {
    int i, min = array[0];
    for (i = 1; i < array_size; i++)
        min = (min < array[i]) ? min : array[i];
    return min;
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Uso: %s <caminho_lista_matrizes>\n", argv[0]);
        return 3;
    }

    int num_matrices, i;
    int **structure = load_structure(argv[1], &num_matrices);
    int result[9];

    for (i = 0; i < 9; i++)
        result[i] = get_min(structure[i], num_matrices);

    print_matrix(result);

    destroy_structure(structure);

    return EXIT_SUCCESS;
}