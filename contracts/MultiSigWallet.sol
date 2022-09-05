// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
    event ConfirmTransaction(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTransaction(address indexed owner, uint indexed txIndex);

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public numConfirmationsRequired;

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public isConfirmed;

    constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        require(_owners.length > 0, "owners required");
        require(
            _numConfirmationsRequired > 0 &&
                _numConfirmationsRequired <= _owners.length,
            "invalid number of required confirmations"
        );

        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        numConfirmationsRequired = _numConfirmationsRequired;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) public onlyOwner {
        uint txIndex = transactions.length;
        transactions.push(
            Transaction({
                to: _to,
                value: _value,
                data: _data,
                executed: false,
                numConfirmations: 0
            })
        );

        emit SubmitTransaction(msg.sender, txIndex, _to, _value, _data);
    }

    function confirmTransaction(uint _txIndex) public onlyOwner {
        Transaction storage transaction = transactions[_txIndex];
        require(transaction.to != address(0), "invalid transaction index");
        require(!transaction.executed, "transaction already executed");
        require(
            !isConfirmed[_txIndex][msg.sender],
            "transaction already confirmed"
        );

        isConfirmed[_txIndex][msg.sender] = true;
        transaction.numConfirmations += 1;

        emit ConfirmTransaction(msg.sender, _txIndex);
    }

    function revokeConfirmation(uint _txIndex) public onlyOwner {
        Transaction storage transaction = transactions[_txIndex];
        require(transaction.to != address(0), "invalid transaction index");
        require(!transaction.executed, "transaction already executed");
        require(isConfirmed[_txIndex][msg.sender], "transaction not confirmed");

        isConfirmed[_txIndex][msg.sender] = false;
        transaction.numConfirmations -= 1;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    function executeTransaction(uint _txIndex) public onlyOwner {
        Transaction storage transaction = transactions[_txIndex];
        require(transaction.to != address(0), "invalid transaction index");
        require(!transaction.executed, "transaction already executed");
        require(
            transaction.numConfirmations >= numConfirmationsRequired,
            "cannot execute transaction"
        );

        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "transaction execution failed");

        emit ExecuteTransaction(msg.sender, _txIndex);
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getTransactionCount(bool _pending, bool _executed)
        public
        view
        returns (uint)
    {
        uint count = 0;
        for (uint i = 0; i < transactions.length; i++) {
            if (
                (_pending && !transactions[i].executed) ||
                (_executed && transactions[i].executed)
            ) {
                count += 1;
            }
        }

        return count;
    }

    function getTransactionIds(
        uint _from,
        uint _to,
        bool _pending,
        bool _executed
    ) public view returns (uint[] memory) {
        uint[] memory transactionIds = new uint[](_to - _from);
        uint count = 0;
        for (uint i = 0; i < transactions.length; i++) {
            if (
                (_pending && !transactions[i].executed) ||
                (_executed && transactions[i].executed)
            ) {
                if (count >= _from && count < _to) {
                    transactionIds[count - _from] = i;
                }

                count += 1;
            }
        }

        return transactionIds;
    }

    function getConfirmations(uint _txIndex)
        public
        view
        returns (address[] memory)
    {
        address[] memory confirmations = new address[](owners.length);
        uint count = 0;
        for (uint i = 0; i < owners.length; i++) {
            if (isConfirmed[_txIndex][owners[i]]) {
                confirmations[count] = owners[i];
                count += 1;
            }
        }

        return confirmations;
    }
}
