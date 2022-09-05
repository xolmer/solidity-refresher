// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AccessControl {
    //role=> account => bool

    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokedRole(bytes32 indexed role, address indexed account);

    mapping(bytes32 => mapping(address => bool)) public roles;
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "AccessControl: Not authorized");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account)
        external
        onlyRole(ADMIN)
    {
        // require(roles[ADMIN][msg.sender], "AccessControl: only admin");
        _grantRole(_role, _account);
    }

    function _revokeRole(bytes32 _role, address _account)
        external
        onlyRole(ADMIN)
    {
        roles[_role][_account] = false;
        emit RevokedRole(_role, _account);
    }
}
