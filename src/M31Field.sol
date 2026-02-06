// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library M31Field {
    uint32 public constant MODULUS = 2147483647;

    uint32 public constant MODULUS_BITS = 31;

    function zero() internal pure returns (uint32) {
        return 0;
    }

    function one() internal pure returns (uint32) {
        return 1;
    }

    function partialReduce(uint32 val) internal pure returns (uint32) {
        if (val >= MODULUS) {
            return val - MODULUS;
        }
        return val;
    }

    function reduce(uint64 val) internal pure returns (uint32) {
        uint64 step1 = (val >> MODULUS_BITS) + val + 1;
        uint64 step2 = (step1 >> MODULUS_BITS) + val;
        return uint32(step2 & uint64(MODULUS));
    }

    function add(uint32 a, uint32 b) internal pure returns (uint32) {
        return partialReduce(a + b);
    }

    function sub(uint32 a, uint32 b) internal pure returns (uint32) {
        return partialReduce(a + MODULUS - b);
    }

    function neg(uint32 a) internal pure returns (uint32) {
        if (a == 0) return 0;

        return partialReduce(MODULUS - a);
    }

    function mul(uint32 a, uint32 b) internal pure returns (uint32) {
        return reduce(uint64(a) * uint64(b));
    }

    function square(uint32 a) internal pure returns (uint32) {
        return reduce(uint64(a) * uint64(a));
    }

    function pow5(uint32 a) internal pure returns (uint32) {
        uint32 a2 = square(a);
        uint32 a4 = square(a2);
        return mul(a4, a);
    }

    function inverse(uint32 a) internal pure returns (uint32) {
        if (a == 0) {
            revert("M31Field: division by zero");
        }
        return pow2147483645(a);
    }

    function fromI32(int32 value) internal pure returns (uint32) {
        if (value < 0) {
            uint64 absValue = uint64(uint32(value >= 0 ? uint32(value) : uint32(-value)));
            uint64 result = (2 * uint64(MODULUS)) - absValue;
            return reduce(result);
        }
        return reduce(uint64(uint32(value)));
    }

    function batchInverse(uint32[] memory elements) internal pure returns (uint32[] memory inverses) {
        uint256 n = elements.length;
        if (n == 0) return new uint32[](0);

        inverses = new uint32[](n);
        uint32[] memory products = new uint32[](n);
        if (elements[0] == 0) {
            revert("M31Field: division by zero");
        }
        products[0] = elements[0];

        for (uint256 i = 1; i < n; i++) {
            if (elements[i] == 0) {
                revert("M31Field: division by zero");
            }
            products[i] = mul(products[i - 1], elements[i]);
        }

        uint32 allInverse = inverse(products[n - 1]);
        for (uint256 i = n - 1; i > 0; i--) {
            inverses[i] = mul(allInverse, products[i - 1]);
            allInverse = mul(allInverse, elements[i]);
        }
        inverses[0] = allInverse;

        return inverses;
    }
    function pow2147483645(uint32 a) internal pure returns (uint32) {
        uint32 t0 = mul(sqn(sqn(a)), a);
        uint32 t1 = mul(sqn(t0), t0);
        uint32 t2 = mul(sqn(sqn(sqn(t1))), t0);
        uint32 t3 = mul(sqn(t2), t0);
        uint32 t4 = mul(sqn8(t3), t3);
        uint32 t5 = mul(sqn8(t4), t3);
        return mul(sqn7(t5), t2);
    }

    function sqn(uint32 v) internal pure returns (uint32) {
        return square(v);
    }

    function sqn7(uint32 v) internal pure returns (uint32) {
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        return v;
    }

    function sqn8(uint32 v) internal pure returns (uint32) {
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        v = square(v);
        return v;
    }

    function isValid(uint32 a) internal pure returns (bool) {
        return a < MODULUS;
    }

    function pow(uint32 base, uint32 exponent) internal pure returns (uint32) {
        if (exponent == 0) return 1;
        if (exponent == 1) return base;
        if (base == 0) return 0;

        uint32 result = 1;
        uint32 currentBase = base;

        while (exponent > 0) {
            if (exponent & 1 == 1) {
                result = mul(result, currentBase);
            }
            currentBase = square(currentBase);
            exponent >>= 1;
        }

        return result;
    }
}
