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

    function testKeccak() public view {
        uint256 gasBefore = gasleft();
        bytes32 hash = keccak256(abi.encodePacked(uint32(123), uint32(456)));
        uint256 gasUsed = gasBefore - gasleft();

        console.log("Gas used for keccak256(123, 456):", gasUsed);
        console.logBytes32(hash);
    }
}
