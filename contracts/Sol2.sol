// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Unboxed, helper} from "./Sol.sol";

contract Import {
    uint public x = helper(1);

    function test() public view returns (uint) {
        if (x != 4) revert Unboxed(x);
        return x;
    }
}
