# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/64abedbd54d8c6538a13099ba9e5e25070bdb754/src/libs/Events.sol)


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

