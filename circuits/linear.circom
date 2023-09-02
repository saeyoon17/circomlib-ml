pragma circom 2.0.0;

include "./circomlib-matrix/.circom";

// matrix multiplication
template linear(B, n, d) {
    signal input a[B][n][d];
    signal input b[B][n][p];
    signal input c[p];
    signal tmp[B][m][p];
    signal output out[B][m][p];
    
    component matMulComp;
    matMulComp = multiMul(B, N, d); // qq랑 kt 곱하기
    matMulComp.a <== a; matMulComp.b <== b;
    tmp <== matMulComp.out;
    
    for (var i=0; i<B; i++) {
        for (var i_=0; i_<n; i_++) {
            for (var i__=0; i__<p; i__++) {
                out[i][i_][i__] <== tmp[i][i_][i__] + c[i__];
            }
        }
    }
}