pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract coin{
    uint contractStartTime;
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
        contractStartTime = block.timestamp;
    }
    function mint(address receiver, uint amount) public onlyMinter amountGreaterThan(amount) {
        balance[receiver]+= amount;
    }
    function send(address receiver, uint amount) public balanceAmountGreaterThanAmount(amount) {
        require(block.timestamp >= contractStartTime + 30);
        balance[msg.sender] -= amount;
        balance[receiver]+=amount;
        emit sent(msg.sender, receiver, amount);
    }

}