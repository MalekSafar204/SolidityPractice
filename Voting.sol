// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Voting {
    string public Winner;
    uint public votesForTrump;
    uint public votesForObama;
    mapping(address => bool) public hasVoted;

    constructor() {}

    function checkVoted() private view returns(bool) {
        return hasVoted[msg.sender];
    }

    function toLowerCase(string memory str) private pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bLower = new bytes(bStr.length);
        for (uint i = 0; i < bStr.length; i++) {
            // Uppercase character
            if (uint8(bStr[i]) >= 65 && uint8(bStr[i]) <= 90) {
                bLower[i] = bytes1(uint8(bStr[i]) + 32);
            } else {
                bLower[i] = bStr[i];
            }
        }
        return string(bLower);
    }

    function isValidCandidate(string memory candidate) private pure returns(bool) {
        string memory candidateLower = toLowerCase(candidate);
        return (keccak256(abi.encodePacked(candidateLower)) == keccak256(abi.encodePacked("trump")) ||
                keccak256(abi.encodePacked(candidateLower)) == keccak256(abi.encodePacked("obama")));
    }

    function VoteFor(string memory candidate) public {
        require(!checkVoted(), "You have already voted");
        require(isValidCandidate(candidate), "Not a valid candidate");

        hasVoted[msg.sender] = true;
        string memory candidateLower = toLowerCase(candidate);
        if (keccak256(abi.encodePacked(candidateLower)) == keccak256(abi.encodePacked("trump"))) {
            votesForTrump++;
        } else {
            votesForObama++;
        }
        updateWinner();
    }

    function updateWinner() private {
        if (votesForObama > votesForTrump) {
            Winner = "Obama";
        } else if (votesForObama < votesForTrump) {
            Winner = "Trump";
        } else {
            Winner = "Tie";
        }
    }
}