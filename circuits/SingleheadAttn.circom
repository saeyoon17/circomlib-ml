pragma circom 2.0.0;

include "./3d_matMul.circom";
include "./multiMul.circom"
include "./transpose.circom"

template SingleheadAttn(B, N, d) {
    signal input q[B][N][d];
    signal input sq[d][d];
    signal input bq[d];
    signal input k[B][N][d];
    signal input sk[d][d];
    signal input bk[d];
    signal input v[B][N][d];
    signal input sv[d][d];
    signal input bv[d];

    signal qq[B][N][d];
    signal kk[B][N][d];
    signal vv[B][N][d];
    signal kt[B][d][N];
    signal aw[B][N][N];

    signal output out[B][N][d];

    component matMulComp;
    matMulComp = linear(B, N, d, d); // q랑 sq 곱하기
    matMulComp.a <== q; matMulComp.b <== sq; matMulComp.c = bq;
    qq <== matMulComp.out;

    component matMulComp2;
    matMulComp2 = linear(B, N, d, d); // k랑 sk 곱하기
    matMulComp2.a <== k; matMulComp2.b <== sk; matMulComp2.c = bk;
    kk <== matMulComp2.out;

    component matMulComp3;
    matMulComp3 = linear(B, N, d, d); // v랑 sv 곱하기
    matMulComp3.a <== v; matMulComp3.b <== sv; matMulComp3.c = bv;
    vv <== matMulComp3.out;

    component matTrans;
    matTrans = transpose(B, N, d); // k 전치행렬 구하기
    matTrans.a <== k; kt <== matTrans.out;

    component matMulComp4;
    matMulComp4 = matMul3d(B, N, d, N); // qq랑 kt 곱하기
    matMulComp4.a <== qq; matMulComp4.b <== kt;
    aw <== matMulComp4.out;

    component matMulComp5;
    matMulComp5 = matMul3d(B, N, N, d); // aw랑 v 곱하기
    matMulComp5.a <== aw; matMulComp5.b <== v;
    out <== matMulComp5.out;
}