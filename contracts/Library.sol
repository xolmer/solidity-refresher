// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

library Math {
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
}

contract Library {
    function testMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint[] storage arr, uint value) internal view returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == value) {
                return i;
            }
        }
        revert("Value not found");
    }
}

contract TestArray {
    using ArrayLib for uint[];
    uint[] public arr = [1, 2, 3, 4, 5];

    function testFind(uint _value) external view returns (uint) {
        // return ArrayLib.find(arr, _value);
        return arr.find(_value);
    }
}
