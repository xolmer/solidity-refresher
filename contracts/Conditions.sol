// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Conditions {
    function example(uint _x) external pure returns (uint) {
        if (_x < 10) {
            return 0;
        } else if (_x < 5) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint _x) external pure returns (uint) {
        return _x < 10 ? 1 : 2;
    }
}

contract ForLoop {
    function forLoop(uint _x) external pure returns (uint) {
        uint sum = 0;
        for (uint i; i < _x; i++) {
            sum += i;
        }
        return sum;
    }

    function whileLoop(uint _x) external pure returns (uint) {
        uint sum = 0;
        uint i = 0;
        while (i < _x) {
            sum += i;
            i++;
        }
        return sum;
    }
}
