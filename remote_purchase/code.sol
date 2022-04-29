pragma solidity >= 0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract PurchaseAgreement {
    uint public value;
    address payable public seller;
    address payable public buyer;

    enum State {created, locked, released, inactive}
    State public state;

    /// The function cannot be called at the current state
    error InvalidState();

    /// Only buyer can call this function
    error OnlyBuyer();

    /// Only seller can call this function
    error OnlySeller();

    modifier inState(State _state){
        if(state != _state){
            revert InvalidState();
        }
        _;
    }
    modifier onlyBuyer(){
        if(msg.sender != buyer){
            revert OnlyBuyer();
        }
        _;
    }
    modifier onlySeller(){
    if(msg.sender != seller){
        revert OnlySeller();
    }
    _;
    }


    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
    }
    function confirmPurchase() external inState(State.created) payable {
        require(msg.value == (2 * value), "please send in 2x purchase amount");
        buyer = payable(msg.sender);
        state = State.locked;
    }
    function confirmRecieved() external onlyBuyer inState(State.locked) {
        state = State.released;
        buyer.transfer(value);
    }

    function paySeller() external onlySeller inState(State.released) {
        state = State.inactive;
        seller.transfer(3 * value);
    }
    
    function abort() external onlySeller inState(State.created) {
        state = State.inactive;
        seller.transfer(address(this).balance);
    }
}