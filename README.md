// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SentimentVoting {
    
    uint256 public positiveVotes;
    uint256 public negativeVotes;
    
    mapping(address => bool) public hasVoted;
    mapping(address => int8) private sentiment;
    
    function setSentiment(address user, int8 value) public {
        require(value == 1 || value == -1, "Sentiment must be 1 or -1");
        sentiment[user] = value;
    }
    
    function vote() public {
        require(!hasVoted[msg.sender], "Already voted");
        hasVoted[msg.sender] = true;
        
        int8 userSentiment = sentiment[msg.sender];
        
        if (userSentiment == 1) {
            positiveVotes += 2;
        } else if (userSentiment == -1) {
            negativeVotes += 1;
        } else {
            positiveVotes += 1;
        }
    }

    function winner() public
