// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MP{
    mapping(uint => address) monthToAddress;
    mapping(address => bool) addressPaid;
    uint16 currMonth;
    uint256 persons;
    uint256 valuePerPerson;
    uint256 total;
    uint256 index;

    constructor(){
        persons = 12;
        valuePerPerson = 1000;
        total = 12000;
    }

    function join() public {
        require(currMonth < 12 );
        monthToAddress[index] = msg.sender;
        index++;
        
    }

    function  pay() public payable {
        require(msg.value == valuePerPerson);

        addressPaid[msg.sender] = true;

        if (address(this).balance == total) {

            edfa3();

            for (uint i = 1; i<=12; i++) 
            {
             addressPaid[monthToAddress[i]] = false;   
            }
        }
    }

    function edfa3() public {
        address toReceive = monthToAddress[currMonth++];

        payable(toReceive).transfer(total);
    }

}