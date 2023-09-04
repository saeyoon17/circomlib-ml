pragma circom 2.0.0;

include "./circomlib/comparators.circom";
include "./util.circom";

template EmbeddingLookup3d (N, d, B, m) {
    signal input a[N][d];
    signal input b[B][m];
    signal output out[B][m][d];

    component sum[B][m][d];
    component eq[B][m][d][N];
    for (var i=0; i<B; i++) {
        for (var i_=0; i_<m; i_++) {
            for (var i__=0; i__<d; i__++) {
                // this basically does out[i][i_][i__] <== a[b[i][i_]][i__];
                // Ref: https://github.com/privacy-scaling-explorations/maci/blob/v1/circuits/circom/trees/incrementalQuinTree.circom#L29
                
                sum[i][i_][i__] = Sum(N);
                for (var bi = 0; bi < N; bi++) {
                    eq[i][i_][i__][bi] = IsEqual();
                    eq[i][i_][i__][bi].in <== [b[i][i_], bi];
                    sum[i][i_][i__].in[bi] <== eq[i][i_][i__][bi].out * a[bi][i__];
                }
                out[i][i_][i__] <== sum[i][i_][i__].out;
            }
        }
    }
}
