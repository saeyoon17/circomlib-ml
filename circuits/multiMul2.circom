pragma circom 2.0.0;

include "./circomlib-matrix/matMul.circom";

// matrix multiplication
template multiMul2 (B, N, d, d2) {
    signal input a[B][N][d];
    signal input b[d][d2];
    signal output out[B][N][d2];

    component matMulComp[B];
    
    for (var i=0; i<B; i++) {
        matMulComp[i] <== matMul(N, d, d2);
        matMulComp[i].a <== a[i];
        matMulComp[i].b <== b;
        out[i] <== matMulComp[i].out;
    }
}
