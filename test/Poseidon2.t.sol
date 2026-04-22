// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Poseidon2} from "../src/Poseidon2.sol";
import {M31Field} from "../src/M31Field.sol";

contract Poseidon2Test is Test {
    function testHashTwoZeroesIsFieldElement() public pure {
        uint32 h = Poseidon2.hashTwo(0, 0);
        assertLt(uint256(h), uint256(M31Field.MODULUS));
        assertEq(h, 1183174448);
    }

    function testHashTwoDeterministic() public pure {
        uint32 h1 = Poseidon2.hashTwo(1, 2);
        uint32 h2 = Poseidon2.hashTwo(1, 2);
        assertEq(h1, h2);
        assertEq(h1, 1975699496);
    }

    function testInputsAreReduced() public pure {
        uint256 big = uint256(M31Field.MODULUS) + 5;
        uint32 h1 = Poseidon2.hashTwo(big, 7);
        uint32 h2 = Poseidon2.hashTwo(5, 7);
        assertEq(h1, h2);
    }

    function testHashTwoVectors() public pure {
        assertEq(Poseidon2.hashTwo(0, 0), 1183174448);
        assertEq(Poseidon2.hashTwo(1, 2), 1975699496);
        assertEq(Poseidon2.hashTwo(5, 10), 442231019);
    }

    function testGasUsage() public view {
        uint256 gasBefore = gasleft();
        Poseidon2.hashTwo(123, 456);
        uint256 gasUsed = gasBefore - gasleft();
        
        // Log gas usage - will be visible with -vv flag
        console.log("Gas used for hashTwo(123, 456):", gasUsed);
    }

    function testQM31HashMatchesM31ForPureInputs() public pure {
        // When upper limbs are 0, poseidon2HashQM31[0] must equal hashTwo
        assertEq(Poseidon2.poseidon2HashQM31([uint32(0),0,0,0], [uint32(0),0,0,0])[0], 1183174448);
        assertEq(Poseidon2.poseidon2HashQM31([uint32(1),0,0,0], [uint32(0),0,0,0])[0], 846768668);
        assertEq(Poseidon2.poseidon2HashQM31([uint32(0),0,0,0], [uint32(1),0,0,0])[0], 1854499991);
        assertEq(Poseidon2.poseidon2HashQM31([uint32(1),0,0,0], [uint32(2),0,0,0])[0], 1975699496);
        assertEq(Poseidon2.poseidon2HashQM31([uint32(100),0,0,0], [uint32(200),0,0,0])[0], 844495285);
    }

    function testQM31HashMatchesHashTwoExactly() public pure {
        // Verify parity with hashTwo for pure M31 inputs
        assertEq(
            Poseidon2.poseidon2HashQM31([uint32(0),0,0,0], [uint32(0),0,0,0])[0],
            Poseidon2.hashTwo(0, 0)
        );
        assertEq(
            Poseidon2.poseidon2HashQM31([uint32(1),0,0,0], [uint32(2),0,0,0])[0],
            Poseidon2.hashTwo(1, 2)
        );
        assertEq(
            Poseidon2.poseidon2HashQM31([uint32(5),0,0,0], [uint32(10),0,0,0])[0],
            Poseidon2.hashTwo(5, 10)
        );
    }

    function testQM31HashCollision() public pure {
        uint32[4] memory r1 = Poseidon2.poseidon2HashQM31([uint32(5),99,0,0], [uint32(42),0,0,0]);
        uint32[4] memory r2 = Poseidon2.poseidon2HashQM31([uint32(5),0,0,0],  [uint32(42),0,0,0]);
        // Different inputs must produce different outputs
        bool differs = r1[0] != r2[0] || r1[1] != r2[1] || r1[2] != r2[2] || r1[3] != r2[3];
        assertTrue(differs);
    }

    function testQM31HashDeterministic() public pure {
        uint32[4] memory h1 = Poseidon2.poseidon2HashQM31([uint32(7),3,1,2], [uint32(9),5,0,4]);
        uint32[4] memory h2 = Poseidon2.poseidon2HashQM31([uint32(7),3,1,2], [uint32(9),5,0,4]);
        assertEq(h1[0], h2[0]);
        assertEq(h1[1], h2[1]);
        assertEq(h1[2], h2[2]);
        assertEq(h1[3], h2[3]);
    }

    function testQM31HashResultIsFieldElements() public pure {
        uint32[4] memory h = Poseidon2.poseidon2HashQM31([uint32(42),13,7,99], [uint32(1),0,2,3]);
        assertLt(uint256(h[0]), uint256(M31Field.MODULUS));
        assertLt(uint256(h[1]), uint256(M31Field.MODULUS));
        assertLt(uint256(h[2]), uint256(M31Field.MODULUS));
        assertLt(uint256(h[3]), uint256(M31Field.MODULUS));
    }

    function testKeccak() public view {
        uint256 gasBefore = gasleft();
        bytes32 hash = keccak256(abi.encodePacked(uint32(123), uint32(456)));
        uint256 gasUsed = gasBefore - gasleft();

        console.log("Gas used for keccak256(123, 456):", gasUsed);
        console.logBytes32(hash);
    }
}
