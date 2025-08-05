// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

abstract contract CodeConstants {
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant LOCAL_CHAIN_ID = 31337;

    /*   MOCK VALUES   */
    uint96 public constant MOCK_BASE_FEE = 0.25 ether; //how much will be required to make a request
    uint96 public constant MOCK_GAS_PRICE_LINK = 1e9;
    uint256 public constant MOCK_WEI_PER_UNIT_LINK = 4e15; //Link/ETH price
}

contract HelperConfig is Script, CodeConstants { 

    //@dev Struct to store the network configuration
    struct NetworkConfig {
        uint256 entranceFee,
        uint256 amountOfParticipantsPerLottery,
        address vrfCoordinator,
        uint256 subId,
        bytes32 keyHash,
        uint32 callbackGasLimit

    }

    //@dev the default configuration for the local network
    NetworkConfig public localNetworkConfig;

    //@dev mapping to store the network configuration
    mapping(uint256 ChainId => NetworkConfig) public networkConfig;

    //@dev error to throw when user inputs the wrong chainId 
    error HelperConfig__WrongId();

    //@dev constructor to initialize the network configuration
    constructor(uint256 _fee, uint256 _amountOfParticipants) {
    networkConfig[ETH_SEPOLIA_CHAIN_ID] = getSepoliaNetworkConfig(_fee, _amountOfParticipants);

    }

    //@dev function that returns the configuration by chainId. If the cha
    function getConfigByChainId(uint256 _chainId) public view returns(NetworkConfig memory) {
        if(networkConfig[_chainId]._vrfCoordinator != address(0)){
            return networkConfig[_chainId];
        }
        if else (_chainId == LOCAL_CHAIN_ID) {
            return getOrCreateAnvilETHConfig(_fee, _amountOfParticipants); 
        }
        else{
            revert HelperConfig__WrongId();
        }

        return networkConfig[_chainId];
    }    

    function getConfig() public view returns(NetworkConfig memory) {
        return getConfigByChainId(block.chainId);
    }

    function getSepoliaNetworkConfig(uint256 _fee, uint256 _amountOfParticipants) public pure returns(NetworkConfig memory) {
        return NetworkConfig({
            entranceFee = _fee;
            amountOfParticipantsPerLottery = _amountOfParticipants;
            vrfCoordinator = 0xD7f86b4b8Cae7D942340FF628F82735b7a20893a;
            subId = 0; //32153869085782592126109247188140873844298886971970160186738317573588513971170
            keyHash = 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae;
            callbackGasLimit = 500_000;
        });

    function getOrCreateAnvilETHConfig(uint256 _fee, uint256 _amountOfParticipants) public returns(NetworkConfig memory) {
        if(localNetworkConfig._vrfCoordinator != address(0)){
            return localNetworkConfig;
        }

        //Deploy the VRFCoordinatorV2_5Mock
        vm.startBroadcast();

        VRFCoordinatorV2_5Mock vrfCoordinatorMock = new VRFCoordinatorV2_5Mock(
        MOCK_BASE_FEE,
        MOCK_GAS_PRICE,
        MOCK_WEI_PER_UNIT_LINK);
        ser
        vm.stopBroadcast();

        return localNetworkConfig = NetworkConfig({
            entranceFee = _fee;
            amountOfParticipantsPerLottery = _amountOfParticipants;
            vrfCoordinator = address(vrfCoordinatorMock);
            subId = 0;
            keyHash = 0x787d74caea10b2b357790d5b5247c2f63d1d91572a9846f780606e4d953677ae;
            callbackGasLimit = 500_000;
        });
    }    
    
}