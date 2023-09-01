pragma circom 2.0.0;

// matrix multiplication by element
template batched_matElemMul (B,m,n) {
    signal input a[B][m][n];
    signal input b[B][m][n];
    signal output out[B][m][n];
    
    for (var i=0; i < m; i++) {
        for (var j=0; j < n; j++) {
            out[B][i][j] <== a[B][i][j] * b[B][i][j];
        }
    }
}
