pragma circom 2.0.0;

// matrix transposing
template transpose (B, N, d) {
    signal input a[B][N][d];
    signal output out[B][d][N];

    for (var i=0; i<B; i++) {
        for (var i_=0; i_<N; i_++) {
            for (var i__=0; i__<d; i__++) {
                out[i][i__][i_] <== a[i][i_][i__];
            }
        }
    }
}