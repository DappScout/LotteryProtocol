# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/563327ba9d4382dac713cff99a3ce1ee38653fe5/src/libs/Events.sol)


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

