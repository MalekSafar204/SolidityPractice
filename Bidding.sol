// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Bidding{
    uint public  highestBid;
    address private  highestBidder;

    constructor() {
        highestBid = 0;
    }  


    function bid() public payable {
        require(msg.value > highestBid + 5, "Bid is too low");
        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    
}