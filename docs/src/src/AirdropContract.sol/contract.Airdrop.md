# Airdrop
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/d06d5c19c0b7001cdfe05f4c06564baf0fabf5d8/src/AirdropContract.sol)

**Inherits:**
VRFConsumerBaseV2Plus, ReentrancyGuard


## State Variables
### NUM_WORDS

```solidity
uint32 private constant NUM_WORDS = 1;
```


### REQUEST_CONFIRMATIONS

```solidity
uint16 private constant REQUEST_CONFIRMATIONS = 3;
```


### i_entranceFee

```solidity
uint256 private immutable i_entranceFee;
```


### i_amountOfParticipantsPerLottery

```solidity
uint256 private immutable i_amountOfParticipantsPerLottery;
```


### i_subId

```solidity
uint256 private immutable i_subId;
```


### i_keyHash

```solidity
bytes32 private immutable i_keyHash;
```


### i_callbackGasLimit

```solidity
uint32 private immutable i_callbackGasLimit;
```


### lotteries

```solidity
lottery[] private lotteries;
```


### s_currentLotteryId

```solidity
uint256 private s_currentLotteryId;
```


## Functions
### constructor


```solidity
constructor(
    uint256 _entranceFee,
    uint256 _amountOfParticipantsPerLottery,
    address _vrfCoordinator,
    uint256 _subId,
    bytes32 _keyHash,
    uint32 _callbackGasLimit
) VRFConsumerBaseV2Plus(_vrfCoordinator);
```

### registerForAirdrop


```solidity
function registerForAirdrop() external payable;
```

### fulfillRandomWords


```solidity
function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override;
```

### startTheRaffle


```solidity
function startTheRaffle() public;
```

### claimTheRewards


```solidity
function claimTheRewards(uint256 _lotteryId) public nonReentrant;
```

## Events
### Registration

```solidity
event Registration(address indexed user);
```

### RaffleStarted

```solidity
event RaffleStarted(uint256 amountOfParticipants, uint256 amountOfTokens, uint256 changesToWinPerParticipant);
```

### winnerSelected

```solidity
event winnerSelected(address indexed winner);
```

## Errors
### AirDrop_WrongAmountOfETHSent

```solidity
error AirDrop_WrongAmountOfETHSent(uint256 msgValue, uint256 i_entranceFee);
```

### AirDrop_NotTheWinner

```solidity
error AirDrop_NotTheWinner();
```

### AirDrop_NoActiveLottery

```solidity
error AirDrop_NoActiveLottery();
```

## Structs
### Participant

```solidity
struct Participant {
    bool active;
    uint256 currentLotteryId;
    uint256 amountToClaim;
}
```

### lottery

```solidity
struct lottery {
    State state;
    Participant[] participants;
    uint256 amountOfParticipants;
    uint256 amountOfTokens;
    uint256 changesToWinPerParticipant;
    address theWinner;
    uint256 time;
}
```

## Enums
### State

```solidity
enum State {
    Registration,
    Waiting,
    Finished
}
```

