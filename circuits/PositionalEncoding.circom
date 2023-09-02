pragma circom 2.0.0;

// sum of all elements in a matrix
template PositionalEncoding (B,N,d) {
    signal input a[B][N][d];
    signal input b[N][d];
    signal output out[B][N][d];

    for (var i=0; i<B; i++) {
        for (var i_=0; i_<N; i_++) {
            for (var i__=0; i__<d; i__++) {
                out[i][i_][i__] <== a[i][i_][i__]+b[i_][i__];
            }
        }
    }
}
