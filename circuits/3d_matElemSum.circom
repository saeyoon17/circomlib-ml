pragma circom 2.0.0;

// sum of all elements in a matrix
template batched_matElemSum (B,m,n) {
    signal input a[B][m][n];
    signal output out;

    signal sum[m*n];
    sum[0] <== a[B][0][0];
    var idx = 0;
    
    for (var i=0; i < m; i++) {
        for (var j=0; j < n; j++) {
            if (idx > 0) {
                sum[idx] <== sum[idx-1] + a[B][i][j];
            }
            idx++;
        }
    }

    out <== sum[m*n-1];
}
