#ifndef EP2_REDUCTION_H
#define EP2_REDUCTION_H

#define imin(a,b) (a<b?a:b) 
__global__ void reduction(int *structure, int *result, int);

#endif //EP2_REDUCTION_H
