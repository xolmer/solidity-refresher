// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CallTestContract {
    function setX(TestContract _test, uint _x) public {
        _test.setX(_x);
    }

    function getX(TestContract _test) public view returns (uint) {
        return _test.x();
    }

    function setXandSendether(TestContract _test, uint _x) public payable {
        _test.setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(TestContract _test)
        public
        view
        returns (uint x, uint value)
    {
        (x, value) = _test.getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value = 0;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value += msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}
