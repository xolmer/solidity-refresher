// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Fallback {
    event Log(string func, address sender, uint value, bytes data);

    fallback() external payable {
        emit Log("fall back", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        //Its executed when the data that was sent to the contract is empty
        emit Log("Receive", msg.sender, msg.value, ""); //msg.data is empty
    }
}

// receive() external payable — for empty calldata (and any value)
// fallback() external payable — when no other function matches (not even the receive function). Optionally payable.
