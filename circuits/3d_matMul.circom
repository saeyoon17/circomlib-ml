pragma circom 2.0.0;

include "3d_matElemMul.circom";
include "3d_matElemSum.circom";

// matrix multiplication
template matMul3d (B, m, n, p) {
    signal input a[B][m][n];
    signal input b[B][n][p];
    signal output out[B][m][p];

    component matElemMulComp[B][m][p];
    component matElemSumComp[B][m][p];
    
    for (var i=0; i<B; i++) {
        for (var i_=0; i_<m; i_++) {
            for (var i__=0; i__<p; i__++) {
                matElemMulComp[i][i_][i__] = batched_matElemMul(i,1,n);
                matElemSumComp[i][i_][i__] = batched_matElemSum(i,1,n);
                for (var i___=0; i___<n; i___++) {
                    matElemMulComp[i][i_][i__].a[i][0][i___] <== a[i][i_][i___];
                    matElemMulComp[i][i_][i__].b[i][0][i___] <== b[i][i___][i__];
                }
                for (var i___=0; i___<n; i___++) {
                    matElemSumComp[i][i_][i__].a[i][0][i___] <== matElemMulComp[i][i_][i__].out[i][0][i___];
                }
                out[i][i_][i__] <== matElemSumComp[i][i_][i__].out;
            }
        }
    }
}
