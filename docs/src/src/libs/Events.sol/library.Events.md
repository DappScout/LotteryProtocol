# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/fcb9c005457bfd4ba80899248ecb39c6e43b4862/src/libs/Events.sol)


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

