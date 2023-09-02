pragma circom 2.0.0;

template sqrtCal () {
    signal input in;
    signal output out;

    var try; try = 0;
    signal s[100]; s[0] <== 0;
    signal e[100]; e[0] <== in;
    signal sum11[100]; signal sum12[100]; signal mid1[100];
    signal sum21[100]; signal sum22[100]; signal mid2[100];
    signal power1[100]; signal power2[100];
    signal minus1[100]; signal minus2[100];
    signal diff1[100]; signal diff2[100];

    while (s < e) {
        sum11[try] <== 2 * s[try];
        sum12[try] <== sum11[try] + e[try];
        mid1[try] <== sum12[try] \ 3;

        sum21[try] <== 2 * e[try];
        sum22[try] <== sum21[try] + s[try];
        mid2[try] <== sum22[try] \ 3;

        power1[try] <== mid1[try] * mid1[try];
        minus1[try] <== power1[try] - in;
        if (minus1[try] < 0) diff1[try] = -minus1[try];
        else diff1[try] = minus1[try];

        power2[try] <== mid2[try] * mid2[try];
        minus2[try] <== power2[try] - in;
        if (minus2[try] < 0) diff2[try] = -minus2[try];
        else diff2[try] = minus2[try];

        if (diff1[try] < diff2[try]) {
            s[try + 1] = s[try];
            e[try + 1] = mid2[try];
        }
        else {
            s[try + 1] = mid1[try];
            e[try + 1] = e[try];
        }
        if (s[try] + 1 == e[try]) break;
        try = try + 1;
    }
    out <== mid1[try];
}