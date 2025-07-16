// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

/*//////////////////////////////////////////////////////////////
                        IMPORTS
///////////////////////////////////////////////////////////////*/
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./libs/Events.sol";

/*//////////////////////////////////////////////////////////////
                  CONTRACT DECLARATION
///////////////////////////////////////////////////////////////*/
contract Airdrop is ReentrancyGuard {
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
    uint256 private immutable entranceFee;
    uint256 private immutable amountOfParticipantsPerLottery;

    lottery[] private lotteries;
    mapping(address => Participant) private participants;

    uint256 private currentLotteryId;

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
    error AirDrop_WrongAmountOfETHSent(uint256 msgValue, uint256 entranceFee);
    error AirDrop_NotTheWinner();
    error AirDrop_NoActiveLottery();

    /*//////////////////////////////////////////////////////////////
                            FUNCTIONS
    ///////////////////////////////////////////////////////////////*/

    /*//////////////////////// CONSTRUCTOR ////////////////////////*/
    constructor(uint256 _entranceFee, uint256 _amountOfParticipantsPerLottery) {
        //Ownable2Step(msg.sender)
        entranceFee = _entranceFee;
        amountOfParticipantsPerLottery = _amountOfParticipantsPerLottery;
    }

    /*///////////////////////// EXTERNAL //////////////////////////*/

    /*///////////////////////// PUBLIC ///////////////////////////*/

    //@notice function that will be called by the user to register for the airdrop
    //@note thing about the order and thing about the situations where time is out, when there is one or zero participants...
    function registerForAirdrop() external payable {
        if (
            lotteries[currentLotteryId].time >= block.timestamp
                && lotteries[currentLotteryId].state != State.Registration
        ) {
            revert AirDrop_NoActiveLottery();
        }

        if (msg.value != entranceFee) {
            revert AirDrop_WrongAmountOfETHSent(msg.value, entranceFee);
        }

        if (
            lotteries[currentLotteryId].time >= block.timestamp //&&
        ) {
            lotteries[currentLotteryId].state = State.Waiting; //@note Im not sure if that state is needed. Maybe I should add "ToClaim" state

            emit RaffleStarted(
                lotteries[currentLotteryId].amountOfParticipants,
                lotteries[currentLotteryId].amountOfTokens,
                lotteries[currentLotteryId].changesToWinPerParticipant
            );
            startTheRaffle();
            emit winnerSelected(lotteries[currentLotteryId].theWinner);
        } else {
            lotteries[currentLotteryId].participants.push(
                Participant({active: true, currentLotteryId: currentLotteryId, amountToClaim: 0})
            );
            lotteries[currentLotteryId].amountOfParticipants++;
            lotteries[currentLotteryId].amountOfTokens += msg.value;
            lotteries[currentLotteryId].changesToWinPerParticipant = entranceFee / amountOfParticipantsPerLottery; //@note precission loss?
            emit Registration(msg.sender);
        }
    }

    //@notice function that will be called by the owner to start the raffle
    //@note This needs to be called by the chainlink automatisation so not onlyOwner
    function startTheRaffle() public {}

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
