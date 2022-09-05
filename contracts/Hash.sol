// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HashFunc {
    function hash(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes memory) {
        return abi.encode(text, num, addr);
    }

    function encodepacked(
        string memory text,
        uint num,
        address addr
    ) external pure returns (bytes memory) {
        return abi.encodePacked(text, num, addr);
    }

    function collision(string memory text, string memory text2)
        external
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(text, text2));
    }

    function collisionFix(
        string memory text,
        uint x,
        string memory text2
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, x, text2));
    }
}
