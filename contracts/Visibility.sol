// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//Solidity Visibility
contract A {
    function foo() public pure virtual returns (bool) {
        return true;
    }

    function bar() internal pure virtual returns (bool) {
        return true;
    }

    function baz() private pure returns (bool) {
        return true;
    }

    function qux() external pure virtual returns (bool) {
        return true;
    }

    function useBaz() public pure returns (bool) {
        return baz();
    }

    function hackUseExternal() public view returns (bool) {
        //Dont use, Gas cost is high
        return this.qux();
    }
}

contract B is A {
    function foo() public pure override returns (bool) {
        return true;
    }

    function bar() internal pure override returns (bool) {
        return true;
    }

    function qux() external pure override returns (bool) {
        return true;
    }

    function useBar() external pure returns (bool) {
        return bar();
    }
}
