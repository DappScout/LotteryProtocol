# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/ef3a689eff9cde4579c3b0e1febe5e031d9e2e5e/src/libs/ErrorsEvents.sol)


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

