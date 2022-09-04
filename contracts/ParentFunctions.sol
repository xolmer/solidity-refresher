// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract E {
    event log(string message);

    function foo() public virtual {
        emit log("E.foo");
    }

    function bar() public virtual {
        emit log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit log("F.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit log("F.bar");
        super.bar();
    }
}

contract G is F {
    function foo() public virtual override {
        emit log("G.foo");
        F.foo();
    }

    function bar() public virtual override {
        emit log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public virtual override(F, G) {
        emit log("H.foo");
        F.foo();
    }

    function bar() public virtual override(F, G) {
        emit log("H.bar");
        super.bar(); // calls all parent functions
    }
}
