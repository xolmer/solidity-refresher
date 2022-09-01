// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Error {
    function testRequire(uint x) public pure returns (uint) {
        require(x > 0, "x must be greater than 0");
        return x;
    }

    function testRevert(uint x) public pure returns (uint) {
        if (x > 0) {
            revert("x must be less than 0");
        }
        return x;
    }

    uint k = 123;

    function testAssert(uint x) public view returns (uint) {
        assert(k == x);
        return x;
    }

    //Custom errors
    error MyError(address _caller, uint i);

    function testMyError(uint x) public view returns (uint) {
        if (x > 0) {
            revert MyError(msg.sender, x);
        }
        return x;
    }
}
