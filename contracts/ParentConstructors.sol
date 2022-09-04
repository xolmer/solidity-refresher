// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract U is S("S"), T("T") {}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

contract VV is S, T("T") {
    constructor(string memory _name) S(_name) {}
}
