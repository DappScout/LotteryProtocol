// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Airdrop} from "../src/AirdropContract.sol";

contract DeploymentScript is Script { 



//Deploy the Airdrop Contract with the vrf variables, and entrance fee, amount of the praticipants
    function deployAirdrop() public returns (Airdrop, HelperConfig) (

        ///create a new helperConfig and get config by chainId from it
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        ) public returns(Airdrop) {
        vm.startBroadcast();
        Airdrop airdrop = new Airdrop(
            config.entranceFee,
            config.amountOfParticipantsPerLottery,
            config.vrfCoordinator,
            config.subId,
            config.keyHash,
            config.callbackGasLimit
        );
        vm.stopBroadcast();
        return (airdrop, helperConfig);
    }   

}