// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function ownerBalance() external view returns (uint256) {
        return owner.balance;
    }

    function depositNonPayable() external {} //Error
}
