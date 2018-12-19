//Caio Henrique Silva Ramos - NUSP 9292991
//Julio Kenji Ueda - NUSP 9298281

#ifndef EP2_REDUCTION_H
#define EP2_REDUCTION_H

#define imin(a,b) (a<b?a:b) 
__global__ void reduction(int *structure, int *result, int);

#endif //EP2_REDUCTION_H
