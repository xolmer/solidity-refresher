// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FunctionOutputs {
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    function named() public pure returns (uint _x, bool _y) {
        _x = 1;
        _y = true;
    }

    function destructingAssignment() public pure returns (uint _x, bool _y) {
        uint x;
        bool y;
        (x, y) = returnMany();
        return (x, y);
    }
}
