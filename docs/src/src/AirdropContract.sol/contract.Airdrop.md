# Airdrop
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/6bebd34177e84edbb011f0bf5a23884b0693d678/src/AirdropContract.sol)

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
Emitted when a user successfully registers for the current lottery


```solidity
event Registration(address indexed user);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`user`|`address`|The address of the user who registered for the airdrop|

### RaffleStarted
Emitted when a raffle is started and ready for winner selection


```solidity
event RaffleStarted(uint256 amountOfParticipants, uint256 amountOfTokens, uint256 changesToWinPerParticipant);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`amountOfParticipants`|`uint256`|The total number of participants in the lottery|
|`amountOfTokens`|`uint256`|The total amount of ETH collected from all participants|
|`changesToWinPerParticipant`|`uint256`|The calculated chances to win per participant (entrance fee divided by total participants)|

### winnerSelected
Emitted when a winner has been selected for the lottery


```solidity
event winnerSelected(address indexed winner);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`winner`|`address`|The address of the selected winner who can claim the prize|

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

