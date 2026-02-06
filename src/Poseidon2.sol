// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {M31Field} from "./M31Field.sol";

library Poseidon2 {
    using M31Field for uint32;

    uint256 private constant N_STATE = 16;
    uint256 private constant N_HALF_FULL_ROUNDS = 4;
    uint256 private constant N_PARTIAL_ROUNDS = 14;


    function getExternalRoundConst(uint256 round, uint256 idx) internal pure returns (uint32) {
        if (round == 0) {
            if (idx == 0) return uint32(0x768bab52);
            if (idx == 1) return uint32(0x70e0ab7d);
            if (idx == 2) return uint32(0x3d266c8a);
            if (idx == 3) return uint32(0x6da42045);
            if (idx == 4) return uint32(0x600fef22);
            if (idx == 5) return uint32(0x41dace6b);
            if (idx == 6) return uint32(0x64f9bdd4);
            if (idx == 7) return uint32(0x5d42d4fe);
            if (idx == 8) return uint32(0x76b1516d);
            if (idx == 9) return uint32(0x6fc9a717);
            if (idx == 10) return uint32(0x70ac4fb6);
            if (idx == 11) return uint32(0x00194ef6);
            if (idx == 12) return uint32(0x22b644e2);
            if (idx == 13) return uint32(0x1f7916d5);
            if (idx == 14) return uint32(0x47581be2);
            if (idx == 15) return uint32(0x2710a123);
        } else if (round == 1) {
            if (idx == 0) return uint32(0x6284e867);
            if (idx == 1) return uint32(0x018d3afe);
            if (idx == 2) return uint32(0x5df99ef3);
            if (idx == 3) return uint32(0x4c1e467b);
            if (idx == 4) return uint32(0x566f6abc);
            if (idx == 5) return uint32(0x2994e427);
            if (idx == 6) return uint32(0x538a6d42);
            if (idx == 7) return uint32(0x5d7bf2cf);
            if (idx == 8) return uint32(0x7fda2dab);
            if (idx == 9) return uint32(0x0fd854c4);
            if (idx == 10) return uint32(0x46922fca);
            if (idx == 11) return uint32(0x3d7763a1);
            if (idx == 12) return uint32(0x19fd05ca);
            if (idx == 13) return uint32(0x0a4bbb43);
            if (idx == 14) return uint32(0x15075851);
            if (idx == 15) return uint32(0x3d903d76);
        } else if (round == 2) {
            if (idx == 0) return uint32(0x2d290ff7);
            if (idx == 1) return uint32(0x40809fa0);
            if (idx == 2) return uint32(0x59dac6ec);
            if (idx == 3) return uint32(0x127927a2);
            if (idx == 4) return uint32(0x6bbf0ea0);
            if (idx == 5) return uint32(0x0294140f);
            if (idx == 6) return uint32(0x24742976);
            if (idx == 7) return uint32(0x6e84c081);
            if (idx == 8) return uint32(0x22484f4a);
            if (idx == 9) return uint32(0x354cae59);
            if (idx == 10) return uint32(0x0453ffe1);
            if (idx == 11) return uint32(0x3f47a3cc);
            if (idx == 12) return uint32(0x0088204e);
            if (idx == 13) return uint32(0x6066e109);
            if (idx == 14) return uint32(0x3b7c4b80);
            if (idx == 15) return uint32(0x6b55665d);
        } else if (round == 3) {
            if (idx == 0) return uint32(0x3bc4b897);
            if (idx == 1) return uint32(0x735bf378);
            if (idx == 2) return uint32(0x508daf42);
            if (idx == 3) return uint32(0x1884fc2b);
            if (idx == 4) return uint32(0x7214f24c);
            if (idx == 5) return uint32(0x7498be0a);
            if (idx == 6) return uint32(0x1a60e640);
            if (idx == 7) return uint32(0x3303f928);
            if (idx == 8) return uint32(0x29b46376);
            if (idx == 9) return uint32(0x5c96bb68);
            if (idx == 10) return uint32(0x65d097a5);
            if (idx == 11) return uint32(0x1d358e9f);
            if (idx == 12) return uint32(0x4a9a9017);
            if (idx == 13) return uint32(0x4724cf76);
            if (idx == 14) return uint32(0x347af70f);
            if (idx == 15) return uint32(0x1e77e59a);
        } else if (round == 4) {
            if (idx == 0) return uint32(0x57090613);
            if (idx == 1) return uint32(0x1fa42108);
            if (idx == 2) return uint32(0x17bbef50);
            if (idx == 3) return uint32(0x1ff7e11c);
            if (idx == 4) return uint32(0x047b24ca);
            if (idx == 5) return uint32(0x4e140275);
            if (idx == 6) return uint32(0x4fa086f5);
            if (idx == 7) return uint32(0x079b309c);
            if (idx == 8) return uint32(0x1159bd47);
            if (idx == 9) return uint32(0x6d37e4e5);
            if (idx == 10) return uint32(0x075d8dce);
            if (idx == 11) return uint32(0x12121ca0);
            if (idx == 12) return uint32(0x7f6a7c40);
            if (idx == 13) return uint32(0x68e182ba);
            if (idx == 14) return uint32(0x5493201b);
            if (idx == 15) return uint32(0x0444a80e);
        } else if (round == 5) {
            if (idx == 0) return uint32(0x0064f4c6);
            if (idx == 1) return uint32(0x6467abe6);
            if (idx == 2) return uint32(0x66975762);
            if (idx == 3) return uint32(0x2af68f9b);
            if (idx == 4) return uint32(0x345b33be);
            if (idx == 5) return uint32(0x1b70d47f);
            if (idx == 6) return uint32(0x053db717);
            if (idx == 7) return uint32(0x381189cb);
            if (idx == 8) return uint32(0x43b915f8);
            if (idx == 9) return uint32(0x20df3694);
            if (idx == 10) return uint32(0x0f459d26);
            if (idx == 11) return uint32(0x77a0e97b);
            if (idx == 12) return uint32(0x2f73e739);
            if (idx == 13) return uint32(0x1876c2f9);
            if (idx == 14) return uint32(0x65a0e29a);
            if (idx == 15) return uint32(0x4cabefbe);
        } else if (round == 6) {
            if (idx == 0) return uint32(0x5abd1268);
            if (idx == 1) return uint32(0x4d34a760);
            if (idx == 2) return uint32(0x12771799);
            if (idx == 3) return uint32(0x69a0c9ac);
            if (idx == 4) return uint32(0x39091e55);
            if (idx == 5) return uint32(0x7f611cd0);
            if (idx == 6) return uint32(0x3af055da);
            if (idx == 7) return uint32(0x7ac0bbdf);
            if (idx == 8) return uint32(0x6e0f3a24);
            if (idx == 9) return uint32(0x41e3b6f7);
            if (idx == 10) return uint32(0x49b3756d);
            if (idx == 11) return uint32(0x568bc538);
            if (idx == 12) return uint32(0x20c079d8);
            if (idx == 13) return uint32(0x1701c72c);
            if (idx == 14) return uint32(0x7670dc6c);
            if (idx == 15) return uint32(0x5a439035);
        } else if (round == 7) {
            if (idx == 0) return uint32(0x7c93e00e);
            if (idx == 1) return uint32(0x561fbb4d);
            if (idx == 2) return uint32(0x1178907b);
            if (idx == 3) return uint32(0x02737406);
            if (idx == 4) return uint32(0x32fb24f1);
            if (idx == 5) return uint32(0x6323b60a);
            if (idx == 6) return uint32(0x6ab12418);
            if (idx == 7) return uint32(0x42c99cea);
            if (idx == 8) return uint32(0x155a0b97);
            if (idx == 9) return uint32(0x53d1c6aa);
            if (idx == 10) return uint32(0x2bd20347);
            if (idx == 11) return uint32(0x279b3d73);
            if (idx == 12) return uint32(0x4f5f3c70);
            if (idx == 13) return uint32(0x0245af6c);
            if (idx == 14) return uint32(0x238359d3);
            if (idx == 15) return uint32(0x49966a59);
        }

        return 0;
    }

    function getInternalRoundConst(uint256 round) internal pure returns (uint32) {
        if (round == 0) return uint32(0x7f7ec4bf);
        if (round == 1) return uint32(0x0421926f);
        if (round == 2) return uint32(0x5198e669);
        if (round == 3) return uint32(0x34db3148);
        if (round == 4) return uint32(0x4368bafd);
        if (round == 5) return uint32(0x66685c7f);
        if (round == 6) return uint32(0x78d3249a);
        if (round == 7) return uint32(0x60187881);
        if (round == 8) return uint32(0x76dad67a);
        if (round == 9) return uint32(0x0690b437);
        if (round == 10) return uint32(0x1ea95311);
        if (round == 11) return uint32(0x40e5369a);
        if (round == 12) return uint32(0x38f103fc);
        if (round == 13) return uint32(0x1d226a21);
        return 0;
    }

    function getInternalDiagConst(uint256 idx) internal pure returns (uint32) {
        if (idx == 0) return uint32(0x07b80ac4);
        if (idx == 1) return uint32(0x6bd9cb33);
        if (idx == 2) return uint32(0x48ee3f9f);
        if (idx == 3) return uint32(0x4f63dd19);
        if (idx == 4) return uint32(0x18c546b3);
        if (idx == 5) return uint32(0x5af89e8b);
        if (idx == 6) return uint32(0x4ff23de8);
        if (idx == 7) return uint32(0x4f78aaf6);
        if (idx == 8) return uint32(0x53bdc6d4);
        if (idx == 9) return uint32(0x5c59823e);
        if (idx == 10) return uint32(0x2a471c72);
        if (idx == 11) return uint32(0x4c975e79);
        if (idx == 12) return uint32(0x58dc64d4);
        if (idx == 13) return uint32(0x06e9315d);
        if (idx == 14) return uint32(0x2cf32286);
        if (idx == 15) return uint32(0x2fb6755d);
        return 0;
    }

    function hashTwo(uint256 left, uint256 right) internal pure returns (uint32) {
        uint32 l = uint32(left % M31Field.MODULUS);
        uint32 r = uint32(right % M31Field.MODULUS);

        uint32[16] memory state;
        state[0] = l;
        state[1] = r;

        // Initial external round matrix as in reference implementation
        applyExternalRoundMatrix(state);

        // First half of full rounds
        unchecked {
            for (uint256 round = 0; round < N_HALF_FULL_ROUNDS; ++round) {
                for (uint256 i = 0; i < N_STATE; ++i) {
                    state[i] = M31Field.add(state[i], getExternalRoundConst(round, i));
                }
                for (uint256 i = 0; i < N_STATE; ++i) {
                    state[i] = M31Field.pow5(state[i]);
                }
                applyExternalRoundMatrix(state);
            }
        }

        // Partial rounds (S-box only on state[0])
        unchecked {
            for (uint256 round = 0; round < N_PARTIAL_ROUNDS; ++round) {
                state[0] = M31Field.add(state[0], getInternalRoundConst(round));
                state[0] = M31Field.pow5(state[0]);
                applyInternalRoundMatrix(state);
            }
        }

        // Second half of full rounds
        unchecked {
            for (uint256 round = 0; round < N_HALF_FULL_ROUNDS; ++round) {
                for (uint256 i = 0; i < N_STATE; ++i) {
                    state[i] = M31Field.add(state[i], getExternalRoundConst(round + N_HALF_FULL_ROUNDS, i));
                }
                for (uint256 i = 0; i < N_STATE; ++i) {
                    state[i] = M31Field.pow5(state[i]);
                }
                applyExternalRoundMatrix(state);
            }
        }

        return state[0];
    }
    /// @notice M4 matrix as in Poseidon2 paper.
    function applyM4(uint32[4] memory x) internal pure returns (uint32[4] memory) {
        uint32 t0 = M31Field.add(x[0], x[1]);
        uint32 t02 = M31Field.add(t0, t0);
        uint32 t1 = M31Field.add(x[2], x[3]);
        uint32 t12 = M31Field.add(t1, t1);
        uint32 t2 = M31Field.add(M31Field.add(x[1], x[1]), t1);
        uint32 t3 = M31Field.add(M31Field.add(x[3], x[3]), t0);
        uint32 t4 = M31Field.add(M31Field.add(t12, t12), t3);
        uint32 t5 = M31Field.add(M31Field.add(t02, t02), t2);
        uint32 t6 = M31Field.add(t3, t5);
        uint32 t7 = M31Field.add(t2, t4);
        return [t6, t5, t7, t4];
    }

    /// @notice External round matrix: circ(2M4, M4, M4, M4) as in Poseidon2 paper.
    function applyExternalRoundMatrix(uint32[16] memory state) internal pure {
        unchecked {
            for (uint256 i = 0; i < 4; ++i) {
                uint32[4] memory slice = [state[4 * i], state[4 * i + 1], state[4 * i + 2], state[4 * i + 3]];
                slice = applyM4(slice);
                state[4 * i] = slice[0];
                state[4 * i + 1] = slice[1];
                state[4 * i + 2] = slice[2];
                state[4 * i + 3] = slice[3];
            }
            for (uint256 j = 0; j < 4; ++j) {
                uint32 s = M31Field.add(M31Field.add(state[j], state[j + 4]), M31Field.add(state[j + 8], state[j + 12]));
                for (uint256 i = 0; i < 4; ++i) {
                    state[4 * i + j] = M31Field.add(state[4 * i + j], s);
                }
            }
        }
    }

    /// @notice Internal round matrix: state[i] = state[i] * mu_i + sum(state), mu_i = 2^{i+1}+1.
    function applyInternalRoundMatrix(uint32[16] memory state) internal pure {
        uint32 sum = state[0];
        unchecked {
            for (uint256 i = 1; i < N_STATE; ++i) {
                sum = M31Field.add(sum, state[i]);
            }
            for (uint256 i = 0; i < N_STATE; ++i) {
                uint32 mu = getInternalDiagConst(i);
                uint32 prod = M31Field.mul(state[i], mu);
                state[i] = M31Field.add(prod, sum);
            }
        }
    }
}
