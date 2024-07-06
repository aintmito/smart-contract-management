# SCM

This Solidity program is a simple smart contract program that demonstrates the basic syntax and functionaly of the Solidity programming language. The purpose of this program is to serve as a starting point for people like me who are new to Solidity and wants to know the fundamentals of how crypto wallet works.

## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract has two functions that deposits and withdraws ETH. This program serves as a simple introduction to Solidity programming. It can be used as a basis and can further improve to a more complex projects in the future.

## Getting Started

### Executing program

* After cloning the github, you will want to do the following to get the code running on your computer.

1. Inside the project directory, in the terminal type: npm i
2. Open two additional terminals in your VS code
3. In the second terminal type: npx hardhat node
4. In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js
5. Back in the first terminal, type npm run dev to launch the front-end.

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/

* To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

* Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract SCM {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
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
}
```

* To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile MyToken.sol" button.

* Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "SCM" contract from the dropdown menu, and then click on the "Deploy" button.

* Once the contract is deployed, you can interact with it by checking the getBalance and owner to check their values.

* Enter a value from the deposit field and press the deposit button afterwards. You can check the updated balance of the account by clicking the getBalance button again.

* Lastly, enter a value from the withdraw field and press the withdraw button afterwards. You can check the updated balance of the account by clicking the getBalance button again.

## Authors

[Miguel Andre Encomienda](https://www.linkedin.com/in/miguel-encomienda-526593292/)


## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details



