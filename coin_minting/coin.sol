pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract coin{
    address public minter;
    mapping(address => uint) public balance;

    event sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balance[receiver]+= amount;
    }
    function send(address receiver, uint amount) public {
        require(amount <= balance[msg.sender], "Insufficient Balance.");
        balance[msg.sender] -= amount;
        balance[receiver]+=amount;
        emit sent(msg.sender, receiver, amount);
    }

}