// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can do this");
        _;
    }

    function setNewOwner(address _newOwner) external onlyOwner {
        require(
            _newOwner != address(0),
            "The new owner cannot be the 0 address"
        );
        owner = _newOwner;
    }
}
