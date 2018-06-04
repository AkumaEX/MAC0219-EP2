#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {

    int i, j, k, num_matrices;

    if (argc != 3) {
        printf("Uso: %s <numero de_matrizes> <arquivo de saida>\n", argv[0]);
        return 3;
    }

    num_matrices = atoi(argv[1]);

    FILE *file = fopen(argv[2], "w");
    fprintf(file, "%d\n", num_matrices);

    srand(time(NULL));

    for (k = 0; k < num_matrices; k++) {
        for (i = 0; i < 3; i++) {
            for (j = 0; j < 3; j++)
                fprintf(file, "%d ", rand());
            fprintf(file, "\n");
        }
        fprintf(file, "\n");
    }

    fclose(file);

    return EXIT_SUCCESS;
}