// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SendEther {
    //3 ways to send ETH
    //transfer - 2300 gas - throws an exception if the transfer fails
    //send - 2300 gas - returns a boolean value
    //call - all gas - returns a boolean value and data

    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    //Dont use send
    function sendViaSend(address payable _to) public payable {
        //All popular smart contract dont use this Send
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

contract ReceiveEther {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
