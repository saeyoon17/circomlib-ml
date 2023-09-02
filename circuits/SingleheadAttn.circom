pragma circom 2.0.0;

include "./3d_matMul.circom";
include "./multiMul.circom"
include "./transpose.circom"

template SingleheadAttn(B, N, d) {
    signal input q[B][N][d];
    signal input sq[d][d];
    signal input k[B][N][d];
    signal input sk[d][d];
    signal input v[B][N][d];
    signal input sv[d][d];

    signal qq[B][N][d];
    signal kk[B][N][d];
    signal vv[B][N][d];
    signal kt[B][d][N];
    signal aw[B][N][N]

    signal output out[B][N][d];

    component matMulComp;
    matMulComp = multiMul(B, N, d, d); // q랑 sq 곱하기
    matMulComp.a <== q; matMulComp.b <== sq;
    qq <== matMulComp.out;

    matMulComp = multiMul(B, N, d, d); // k랑 sk 곱하기
    matMulComp.a <== k; matMulComp.b <== sk;
    kk <== matMulComp.out;

    matMulComp = multiMul(B, N, d, d); // v랑 sv 곱하기
    matMulComp.a <== v; matMulComp.b <== sv;
    vv <== matMulComp.out;

    component matTrans;
    matTrans = transpose(B, N, d); // k 전치행렬 구하기
    matTrans.a <== k; kt <== matTrans.out;

    matMulComp = matMul3d(B, N, d, N); // qq랑 kt 곱하기
    matMulComp.a <== qq; matMulComp.b <== kt;
    aw <== matMulComp.out;

    matMulComp = matMul3d(B, N, N, d); // aw랑 v 곱하기
    matMulComp.a <== aw; matMulComp.b <== v;
    out <== matMulComp.out;
}