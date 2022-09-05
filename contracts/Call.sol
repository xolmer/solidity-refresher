// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("Fallback called with");
    }

    receive() external payable {
        emit Log("Receive called with");
    }

    function foo(string memory _message, uint _value)
        external
        payable
        returns (bool, uint)
    {
        message = _message;
        x = _value;
        emit Log("foo called with");
        return (true, 42);
    }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111}(
            abi.encodeWithSignature("foo(string,uint256)", "Hello", 123)
        );
        require(success, "Call failed");
        data = _data;
    }

    function callDoesNotExist(address _test) external {
        (bool success, ) = _test.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(!success, "Call should have failed");
    }
}
