# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/d06d5c19c0b7001cdfe05f4c06564baf0fabf5d8/src/libs/Events.sol)


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

