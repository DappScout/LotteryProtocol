# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/a7e28bf545dd695cbab49a48fd7a276f6cc42b8b/src/libs/Events.sol)


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

