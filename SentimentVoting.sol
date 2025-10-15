// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SentimentVoting {
    
    // Track votes
    uint256 public positiveVotes;
    uint256 public negativeVotes;
    
    // Track if an address has voted
    mapping(address => bool) public hasVoted;
    
    // Simulated sentiment for addresses (1 = positive, -1 = negative)
    mapping(address => int8) internal sentiment;
    
    // Assign some default sentiment for demonstration
    // In real scenario, this would come from off-chain sentiment analysis
    function setSentiment(address user, int8 value) public {
        require(value == 1 || value == -1, "Sentiment must be 1 or -1");
        sentiment[user] = value;
    }
    
    // Vote influenced by sentiment
    function vote() public {
        require(!hasVoted[msg.sender], "Already voted");
        
        hasVoted[msg.sender] = true;
        
        if(sentiment[msg.sender] == 1) {
            positiveVotes += 2; // positive sentiment counts double
        } else if(sentiment[msg.sender] == -1) {
            negativeVotes += 1;
        } else {
            positiveVotes += 1; // neutral/default vote
        }
    }
    
    // Get winner
    function winner() public view returns (string memory) {
        if(positiveVotes > negativeVotes) {
            return "Positive wins!";
        } else if(negativeVotes > positiveVotes) {
            return "Negative wins!";
        } else {
            return "It's a tie!";
        }
    }
}
