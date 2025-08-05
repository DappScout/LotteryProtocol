// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

interface Errors {
    /*//////////////////////////////////////////////////////////////
                            ERRORS
    ///////////////////////////////////////////////////////////////*/
    error AirDrop_WrongAmountOfETHSent(uint256 msgValue, uint256 i_entranceFee);
    error AirDrop_NotTheWinner();
    error AirDrop_NoActiveLottery();
}

interface Events {
    /*//////////////////////////////////////////////////////////////
                            EVENTS
    ///////////////////////////////////////////////////////////////*/
    
    /// @notice Emitted when a user successfully registers for the current lottery
    /// @param user The address of the user who registered for the airdrop
    event Registration(address indexed user);
    
    /// @notice Emitted when a raffle is started and ready for winner selection
    /// @param amountOfParticipants The total number of participants in the lottery
    /// @param amountOfTokens The total amount of ETH collected from all participants
    /// @param changesToWinPerParticipant The calculated chances to win per participant (entrance fee divided by total participants)
    event RaffleStarted(uint256 amountOfParticipants, uint256 amountOfTokens, uint256 changesToWinPerParticipant);
    
    /// @notice Emitted when a winner has been selected for the lottery
    /// @param winner The address of the selected winner who can claim the prize
    event winnerSelected(address indexed winner);
}