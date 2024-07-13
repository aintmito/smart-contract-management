// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;
    uint256 public loanBalance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event LoanTaken(uint256 amount);
    event LoanPaid(uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
        loanBalance = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this account");
        _;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    function loan(uint256 _loanAmount) public onlyOwner {
        require(balance >= _loanAmount, "Insufficient contract balance for loan");

        // Update the contract balance and loan balance
        balance -= _loanAmount;
        loanBalance += _loanAmount;

        // Emit the loan taken event
        emit LoanTaken(_loanAmount);
    }

    function getLoanBalance() public view returns (uint256) {
        return loanBalance;
    }

    function payLoan(uint256 _paymentAmount) public onlyOwner {
        require(_paymentAmount <= loanBalance, "Cannot pay more than the loan balance");
        require(balance >= _paymentAmount, "Insufficient contract balance to pay loan");

        // Update the contract balance and loan balance
        balance -= _paymentAmount;
        loanBalance -= _paymentAmount;

        // Emit the loan paid event
        emit LoanPaid(_paymentAmount);
    }
}
