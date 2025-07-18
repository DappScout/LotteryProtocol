// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Airdrop is VRFConsumerBaseV2Plus, ReentrancyGuard {
    /*//////////////////////////////////////////////////////////////
                        TYPE DECLARATIONS
    ///////////////////////////////////////////////////////////////*/
    enum State {
        Registration,
        Waiting,
        Finished
    }

    struct Participant {
        bool active;
        uint256 currentLotteryId;
        uint256 amountToClaim;
    }

    struct lottery {
        State state;
        Participant[] participants;
        uint256 amountOfParticipants;
        uint256 amountOfTokens;
        uint256 changesToWinPerParticipant;
        address theWinner;
        uint256 time;
    }

    /*//////////////////////////////////////////////////////////////
                        STATE VARIABLES
    ///////////////////////////////////////////////////////////////*/
    uint32 private constant NUM_WORDS = 1;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_amountOfParticipantsPerLottery;
    uint256 private immutable i_subId;
    bytes32 private immutable i_keyHash;
    uint32 private immutable i_callbackGasLimit;

    lottery[] private lotteries;

    uint256 private s_currentLotteryId;

    /*//////////////////////////////////////////////////////////////
                            EVENTS
    ///////////////////////////////////////////////////////////////*/
    event Registration(address indexed user);
    event RaffleStarted(uint256 amountOfParticipants, uint256 amountOfTokens, uint256 changesToWinPerParticipant);
    event winnerSelected(address indexed winner);

    /*//////////////////////////////////////////////////////////////
                           MODIFIERS
    ///////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                            ERRORS
    ///////////////////////////////////////////////////////////////*/
    error AirDrop_WrongAmountOfETHSent(uint256 msgValue, uint256 i_entranceFee);
    error AirDrop_NotTheWinner();
    error AirDrop_NoActiveLottery();

    /*//////////////////////////////////////////////////////////////
                            FUNCTIONS
    ///////////////////////////////////////////////////////////////*/

    /*//////////////////////// CONSTRUCTOR ////////////////////////*/
    constructor(
        uint256 _entranceFee, 
        uint256 _amountOfParticipantsPerLottery, 
        address _vrfCoordinator,
        uint256 _subId,
        bytes32 _keyHash,
        uint32 _callbackGasLimit
        ) 
    VRFConsumerBaseV2Plus(_vrfCoordinator){
        //Ownable2Step(msg.sender)
        i_entranceFee = _entranceFee;
        i_amountOfParticipantsPerLottery = _amountOfParticipantsPerLottery;
        i_subId = _subId;
        i_keyHash = _keyHash;
        i_callbackGasLimit = _callbackGasLimit;

    }

    /*///////////////////////// EXTERNAL //////////////////////////*/

    /*///////////////////////// PUBLIC ///////////////////////////*/

    //@notice function that will be called by the user to register for the airdrop
    //@note thing about the order and thing about the situations where time is out, when there is one or zero participants...
    function registerForAirdrop() external payable {
        if (
            lotteries[s_currentLotteryId].time >= block.timestamp
                && lotteries[s_currentLotteryId].state != State.Registration
        ) {
            revert AirDrop_NoActiveLottery();
        }

        if (msg.value != i_entranceFee) {
            revert AirDrop_WrongAmountOfETHSent(msg.value, i_entranceFee);
        }

        if (
            lotteries[s_currentLotteryId].time >= block.timestamp //&&
        ) {
            lotteries[s_currentLotteryId].state = State.Waiting; //@note Im not sure if that state is needed. Maybe I should add "ToClaim" state

            emit RaffleStarted(
                lotteries[s_currentLotteryId].participants.length,
                lotteries[s_currentLotteryId].amountOfTokens,
                lotteries[s_currentLotteryId].changesToWinPerParticipant
            );

            startTheRaffle();
            
            emit winnerSelected(lotteries[s_currentLotteryId].theWinner);
        
        } else {
            lotteries[s_currentLotteryId].participants.push(
                Participant({active:true,currentLotteryId: s_currentLotteryId, amountToClaim: 0})
            );
            lotteries[s_currentLotteryId].amountOfTokens += msg.value;
            lotteries[s_currentLotteryId].changesToWinPerParticipant = i_entranceFee / i_amountOfParticipantsPerLottery; //@note precission loss?
            
            emit Registration(msg.sender);
        }
    }

    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override {
    }
    

    //@notice function that will be called by the owner to start the raffle
    //@note This needs to be called by the chainlink automatisation so not onlyOwner
    function startTheRaffle() public {


        uint256 requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: i_keyHash,
                subId: i_subId,
                requestConfirmations: REQUEST_CONFIRMATIONS,
                callbackGasLimit: i_callbackGasLimit,
                numWords: NUM_WORDS,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            }));

    }

    function claimTheRewards(uint256 _lotteryId) public nonReentrant {
        if (msg.sender != lotteries[_lotteryId].theWinner) revert AirDrop_NotTheWinner();

        (bool success,) = payable(msg.sender).call{value: lotteries[_lotteryId].amountOfTokens}("");
        require(success, "Transfer failed");
    }

    /*//////////////////////// INTERNAL //////////////////////////*/

    /*///////////////////////// PRIVATE ///////////////////////////*/

    /*/////////////////////// VIEW & PURE /////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                        CODE SNIPPETS
    ///////////////////////////////////////////////////////////////*/
    /* request - Chainlink VRF

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: s_keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })


    */

    /*
    // Layout of the contract file:
    // version
    // imports
    // errors
    // interfaces, libraries, contract
    ​
    // Inside Contract:
    // Type declarations
    // State variables
    // Events
    // Modifiers
    // Functions
    ​
    // Layout of Functions:
    // constructor
    // receive function (if exists)
    // fallback function (if exists)
    // external
    // public
    // internal
    // private
    // view & pure functions
    */
}
