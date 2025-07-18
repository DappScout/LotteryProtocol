pragma solidity 0.8.30;

library Events {
    event Registration(address indexed user);
    event RaffleStarted(uint256 amountOfParticipants, uint256 amountOfTokens, uint256 changesToWinPerParticipant);
    event winnerSelected(address indexed winner);
}
