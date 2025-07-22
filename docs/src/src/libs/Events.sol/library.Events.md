# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/ea72857ecf456aac89ddb541e3d0b28a3b5b61c3/src/libs/Events.sol)


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

