// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ICounter {
    function count() external view returns (uint);

    function increment() external;

    function decrement() external;
}

contract CallInterface {
    function getCount(ICounter _counter) public view returns (uint) {
        return _counter.count();
    }

    function increment(ICounter _counter) public {
        _counter.increment();
    }

    function decrement(ICounter _counter) public {
        _counter.decrement();
    }

    function example(address _counter) public {
        ICounter counter = ICounter(_counter);

        counter.increment();
        counter.decrement();
        counter.count();

        ICounter(_counter).increment();
        ICounter(_counter).decrement();
        ICounter(_counter).count();
    }
}

contract Counter {
    uint public count;

    function increment() public {
        count++;
    }

    function decrement() public {
        count--;
    }
}
