pragma circom 2.0.0;

include "./circomlib-matrix/.circom";

// matrix multiplication
template linear(B, N, d) {
    signal input a[B][N][d];
    signal input b[d][d];
    signal input c[d];
    signal tmp[B][N][d];
    signal output out[B][N][d];
    
    component matMulComp;
    matMulComp = multiMul(B, N, d);
    matMulComp.a <== a; matMulComp.b <== b;
    tmp <== matMulComp.out;
    
    for (var i=0; i<B; i++) {
        for (var i_=0; i_<N; i_++) {
            for (var i__=0; i__<d; i__++) {
                out[i][i_][i__] <== tmp[i][i_][i__] + c[i__];
            }
        }
    }
}