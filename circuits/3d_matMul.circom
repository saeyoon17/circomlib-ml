pragma circom 2.0.0;

include "./circomlib-matrix/matMul.circom";

// matrix multiplication
template matMul3d (B, m, n, p) {
    signal input a[B][m][n];
    signal input b[B][n][p];
    signal output out[B][m][p];

    component matMulComp[B];
    
    for (var i=0; i<B; i++) {
        matMulComp[i] = matMul(m, n, p);
        matMulComp[i].a <== a[i];
        matMulComp[i].b <== b[i];
        out[i] <== matMulComp[i].out;
    }
}
