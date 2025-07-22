# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/922e04fab0e2032ff61fdafbed439f4afcc8f95f/src/libs/Events.sol)


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

