// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {Airdrop} from "../src/AirdropContract.sol";

contract DeploymentScript is Script { 

    function deployAirdrop(
        uint256 _entranceFee,
        uint256 _amountOfParticipantsPerLottery,
        address _vrfCoordinator,
        uint256 _subId,
        bytes32 _keyHash,
        uint32 _callbackGasLimit
        ) public {
        vm.startBroadcast();
        Airdrop airdrop = new Airdrop(
            _entranceFee,
            _amountOfParticipantsPerLottery,
            _vrfCoordinator,
            _subId,
            _keyHash,
            _callbackGasLimit
        );
        vm.stopBroadcast(); 
    }   

}