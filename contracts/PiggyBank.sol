// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract PiggyBank {
    event Deposite(uint indexed amount);
    event Withdraw(uint indexed amount);
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function withdraw() external onlyOwner {
        emit Withdraw(address(this).balance);
        selfdestruct(payable(owner));
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
