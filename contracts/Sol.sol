// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

function helper(uint x) pure returns (uint) {
    return x + 2;
}

error Unboxed(uint x);

contract Sol {
    function testUnderFlow() public pure returns (uint) {
        uint256 x = 0;
        {
            x--;
        }
        return x;
    }

    function testUnderFlowUnchecked() public pure returns (uint) {
        uint256 x = 0;
        unchecked {
            x--;
        }
        return x;
    }
}

contract VendingMachine {
    address payable owner = payable(msg.sender);

    error Xolmer();

    function withdraw() public {
        if (msg.sender != owner) revert Xolmer();
        owner.transfer(address(this).balance);
    }
}
