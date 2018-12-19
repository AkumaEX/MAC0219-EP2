//Caio Henrique Silva Ramos - NUSP 9292991
//Julio Kenji Ueda - NUSP 9298281

#include <stdio.h>
#include <limits.h>
#include "reduction.h"

__global__ void reduction(int *structure, int *result, int N) {

	//Shared vector for min's
    extern __shared__ int sdata[];  
	int i = threadIdx.x;
	int tid = blockIdx.x*blockDim.x+threadIdx.x;
	
	int min = INT_MAX;
	while(tid < N) {
		min = imin(min, structure[tid]);
		tid += blockDim.x*gridDim.x;
	}

	sdata[i] = min;	
	__syncthreads();

	//Compute the min's
	int s = blockDim.x/2;
	while(s != 0) {
		if(i < s) {
			sdata[i] = imin(sdata[i], sdata[i+s]);
		}

		__syncthreads();
		s /= 2;
	}
	//Save the results
	if(i == 0) result[blockIdx.x] = sdata[0];
}
