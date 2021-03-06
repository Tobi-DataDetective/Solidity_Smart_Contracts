pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract simpleAuction{
    // parameters of the auction
    address payable public beneficiary;
    uint public auctionEndTime;

    // Current state of the auctionEndTime
    address public highestBidder;
    uint public highestBid;
    mapping(address=>uint) public pendingReturns;

    bool ended = false ;

    event HighestBidIncrease(address bidder, uint amount);
    event auctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _beneficiary){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }
    function bid() public payable {
        if (block.timestamp > auctionEndTime){
            revert("the auction as already ended");
        }
        if (msg.value <= highestBid){
            revert( 'There is already a higherbid or equal bid');
        }
        if (highestBid != 0){
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncrease( msg.sender, msg.value);
    }
    function withdraw()public returns (bool){
        uint amount = pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;

            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
    function aunctionEnd() public {
        if (block.timestamp < auctionEndTime){
            revert("The auction has not ended yet");
        }
        if (ended){
            revert("The function auctionEnded has already been called");
        }
        ended = true;
        emit auctionEnded(highestBidder, highestBid);

        beneficiary.transfer(highestBid);
    }
}