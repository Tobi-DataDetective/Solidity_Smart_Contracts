pragma solidity >= 0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract Escrow {
    // variables
    enum State {NOT_INITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETED}

    State public currState;

    bool public isBuyerIn;
    bool public isSellerIn;

    uint public price;

    address public buyer;
    address payable public seller;

    // modifiers
    modifier onlyBuyer(){
        require(msg.sender == buyer, "Only buyer can call this function");
        _;
    }
    modifier escrowNotStarted(){
        require(currState == State.NOT_INITIATED);
        _;
    }

    // functions
    constructor(address _buyer, address payable _seller, uint _price){
        buyer = _buyer;
        seller = _seller;
        price = _price * (1 ether);
    }
    function initContract() escrowNotStarted public {
        if(msg.sender == buyer){
            isBuyerIn = true;
        }
        if(msg.sender == seller){
            isSellerIn = true;
        }
        if (isBuyerIn && isSellerIn){
            currState = State.AWAITING_PAYMENT;
        }
    }
    function deposit() onlyBuyer public payable {
        require(currState == State.AWAITING_PAYMENT, "Already Paid");
        require(msg.value == price, "wrong deposit amount");
        currState = State.AWAITING_DELIVERY;
    }
    function confirmDelivery() onlyBuyer payable public {
        require(currState == State.AWAITING_DELIVERY, "cannot confirm delivery");
        seller.transfer(price);
        currState =State.COMPLETED;

    }
    function withDraw() onlyBuyer payable public {
        require(currState == State.AWAITING_DELIVERY, "cannot withdraw at this stage");
        payable(msg.sender).transfer(price);
        currState = State.COMPLETED;
    }
}