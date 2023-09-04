const chai = require("chai");
const path = require("path");

const wasm_tester = require("circom_tester").wasm;

const F1Field = require("ffjavascript").F1Field;
const Scalar = require("ffjavascript").Scalar;
exports.p = Scalar.fromString("21888242871839275222246405745257275088548364400416034343698204186575808495617");
const Fr = new F1Field(exports.p);

const assert = chai.assert;

describe("Sqrt test", function () {
    this.timeout(100000000);

    it("Sqrt random number", async () => {
        const circuit = await wasm_tester(path.join(__dirname, "../circuits", "sqrtCal.circom"));
        //await circuit.loadConstraints();
        //assert.equal(circuit.nVars, 18);
        //assert.equal(circuit.constraints.length, 6);

        // js random number from 0 to 1e23
        const r = Math.floor(Math.random()*1e15);
        console.log("r = ", r);
        console.log("sqrt(r) = ", Math.floor(Math.sqrt(r)));
        const INPUT = {
          "in": r.toString(),
        }

        const witness = await circuit.calculateWitness(INPUT, true);
        console.log(witness[0]);

        assert(Fr.eq(Fr.e(witness[0]),Fr.e(Math.floor(Math.sqrt(r)))));
    });
});