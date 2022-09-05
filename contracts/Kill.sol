// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testReturn() external pure returns (uint256) {
        return 1;
    }
}

contract Helper {
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function killHelper(Kill _kill) external {
        _kill.kill();
    }

    // function killHelper2(address payable _kill) external {
    //     selfdestruct(_kill);
    // }
}
