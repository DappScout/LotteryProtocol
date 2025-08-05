pragma solidity 0.8.30;

interface Errors {
    /*//////////////////////////////////////////////////////////////
                            ERRORS
    ///////////////////////////////////////////////////////////////*/
    error AirDrop_WrongAmountOfETHSent(uint256 msgValue, uint256 i_entranceFee);
    error AirDrop_NotTheWinner();
    error AirDrop_NoActiveLottery();
}
