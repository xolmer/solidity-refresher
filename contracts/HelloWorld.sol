// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Hello {
    string public myString = "Hello World!";

    function sayHello() public view returns (string memory) {
        return myString;
    }
}

contract DataTypes {
    //Data Types - values and references
    bool public isWhore;
    address public myAddress;
    uint public myUint;
    int public netagiveInt = -1;

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    bytes32 public myBytes32 =
        0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;
}

contract FunctionIntro {
    function addition(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function sub(uint a, uint b) public pure returns (uint) {
        return a - b;
    }
}

contract StateVariable {
    uint public stateVariable;
    uint public i;
    address public myAddress;

    function localVariables() external {
        uint x = 123;
        bool f = true;

        x += 1;
        f = false;

        i = 123;
        stateVariable = 24;
        myAddress = address(1);
    }
}

contract GlobalVariable {
    function glovalVariables()
        external
        view
        returns (
            address,
            uint,
            uint
        )
    {
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}

contract ViewAndPureFunctions {
    uint public x = 1;

    function addToX(uint y) public view returns (uint) {
        return x + y;
    }

    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}
