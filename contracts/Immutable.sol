// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Immutable {
    address public immutable owner; //Immutable will save gas and can only be initialized once like Constants

    constructor() {
        owner = msg.sender;
    }

    uint public x;

    function foo() public {
        require(msg.sender == owner, "Not owner");
        x += 1;
    }
}
