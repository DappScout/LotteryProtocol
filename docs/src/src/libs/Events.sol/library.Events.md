# Events
[Git Source](https://github.com/DappScout/LotteryProtocol/blob/b4697cfda28ed746a28f8b2c69072e8d5eeccfcc/src/libs/Events.sol)


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

