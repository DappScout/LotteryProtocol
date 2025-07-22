# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/6bebd34177e84edbb011f0bf5a23884b0693d678/src/libs/Events.sol)


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

