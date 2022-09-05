// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "You are not the owner");
        payable(msg.sender).transfer(_amount); //save gas instead of owner.transfer(_amount);

        //--- use call for transfer
        // (bool sent, ) = msg.sender.call{value: _amount}("");
        // require(sent, "Failed to send Ether");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
