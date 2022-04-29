pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT


/*
Modifier: can be used to change the bahaviour of functions in a declarative way. 
            For example, you can use a modifier to automatically check a condition prios to executing the function
*/

contract coin{
    address public minter;
    mapping(address => uint) public balance;

    event sent(address from, address to, uint amount);

    modifier onlyMinter {
        require(msg.sender == minter, "only minter can call this function");
        _;
    }
    modifier amountGreaterThan(uint amount) {
        require(amount < 1e60);
        _;
    }
    modifier balanceAmountGreaterThanAmount(uint amount) {
        require(amount <= balance[msg.sender], "Insufficient Balance.");
        _;
    }
    constructor(){
        minter = msg.sender;
    }
    function mint(address receiver, uint amount) public onlyMinter amountGreaterThan(amount) {
        // require(msg.sender == minter);
        // require(amount < 1e60);
        balance[receiver]+= amount;
    }
    function send(address receiver, uint amount) public balanceAmountGreaterThanAmount(amount) {
        // require(amount <= balance[msg.sender], "Insufficient Balance.");
        balance[msg.sender] -= amount;
        balance[receiver]+=amount;
        emit sent(msg.sender, receiver, amount);
    }

}