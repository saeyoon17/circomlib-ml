pragma circom 2.0.0;

template EmbeddingLookup3d (N, d, B, m) {
    signal input a[N][d];
    signal input b[B][m];
    signal output out[B][m][d];

    for (var i=0; i<B; i++) {
        for (var i_=0; i_<m; i_++) {
            for (var i__=0; i__<d; i__++) {
                out[i][i_][i__] <== a[b[i][i_]][i__];
            }
        }
    }
}
