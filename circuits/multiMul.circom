pragma circom 2.0.0;

include "./circomlib-matrix/matMul.circom";

// matrix multiplication
template multiMul (B, N, d) {
    signal input a[B][N][d];
    signal input b[d][d];
    signal output out[B][m][p];

    component matMulComp[B];
    
    for (var i=0; i<B; i++) {
        matMulComp[i] <== matMul(N, d, d);
        matMulComp[i].a <== a[i];
        matMulComp[i].b <== b;
        out[i] <== matMulComp[i].out;
    }
}
