# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/9f80f4d4b35079a5dd151221169aa0fe62eebb1d/src/libs/Events.sol)


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

