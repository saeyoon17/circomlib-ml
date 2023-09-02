pragma circom 2.0.0;

include "./circomlib-matrix/.circom";

// matrix multiplication
template linear(B, N, d, d2) {
    signal input a[B][N][d];
    signal input b[d][d2];
    signal input c[d2];
    signal tmp[B][N][d2];
    signal output out[B][N][d2];
    
    component matMulComp;
    matMulComp = multiMul2(B, N, d, d2);
    matMulComp.a <== a; matMulComp.b <== b;
    tmp <== matMulComp.out;
    
    for (var i=0; i<B; i++) {
        for (var i_=0; i_<N; i_++) {
            for (var i__=0; i__<d2; i__++) {
                out[i][i_][i__] <== tmp[i][i_][i__] + c[i__];
            }
        }
    }
}