# Random Airdrop Selector using Chainlink VRF

A Solidity project to learn Chainlink VRF (Verifiable Random Function) by building a fair and transparent airdrop system.

## What We're Building

This project demonstrates how to use Chainlink VRF to create a provably fair airdrop system where random winners are selected from a pool of registered participants. Unlike traditional airdrops that might be first-come-first-serve or based on arbitrary criteria, this system uses verifiable randomness to ensure fairness.

## Project Overview

### The Problem
Traditional airdrops often face issues with:
- **Unfairness**: First-come-first-serve advantage
- **Gaming**: Users creating multiple accounts (Sybil attacks)
- **Lack of Transparency**: Users can't verify the selection process was fair
- **Centralized Selection**: Developers could potentially manipulate winners

### Our Solution
A smart contract that:
1. Allows eligible users to register during an open period
2. Uses Chainlink VRF to randomly select winners
3. Provides transparent, verifiable randomness
4. Ensures fair distribution of tokens

## How It Works

### Phase 1: Registration
- Users call `registerForAirdrop()` to enter the pool
- Registration is open for a specified time period
- Each address can only register once
- Optional: Require minimum token balance to prevent Sybil attacks

### Phase 2: Random Selection
- After registration closes, admin triggers winner selection
- Chainlink VRF generates verifiable random numbers
- Smart contract uses randomness to select winner indices
- All participants can verify the selection was truly random

### Phase 3: Token Distribution
- Selected winners can claim their airdrop tokens
- Claims must be made within a specified timeframe
- Unclaimed tokens can be redistributed or returned

## Key Learning Objectives

By building this project, you'll learn:

### Chainlink VRF Integration
- How to request random numbers from Chainlink VRF
- Implementing VRF callback functions
- Handling VRF subscription and LINK token payments
- Managing request IDs and async responses

### Smart Contract Patterns
- Registration and eligibility systems
- Time-based contract phases
- Admin controls and access management
- Token distribution mechanics

### Security Considerations
- Preventing reentrancy attacks
- Input validation and error handling
- Managing contract state transitions
- Gas optimization for batch operations

## Technical Stack

- **Solidity**: Smart contract development
- **Chainlink VRF**: Verifiable random number generation
- **OpenZeppelin**: Security and standard implementations
- **Hardhat/Foundry**: Development and testing framework
- **ERC20**: Token standard for airdrop distribution

## Contract Architecture

```
RandomAirdrop.sol
├── Registration System
│   ├── User registration
│   ├── Eligibility checks
│   └── Anti-sybil measures
├── VRF Integration
│   ├── Random number requests
│   ├── Callback handling
│   └── Winner selection logic
└── Distribution System
    ├── Token claiming
    ├── Time-locked claims
    └── Leftover handling
```

## Features to Implement

### Core Features
- [x] User registration system
- [x] Chainlink VRF integration
- [x] Random winner selection
- [x] Token claim mechanism
- [x] Admin controls

### Advanced Features (Optional)
- [ ] Weighted selection (based on token holdings)
- [ ] Multi-tier prizes (1st, 2nd, 3rd place)
- [ ] Registration fees (paid back to winners)
- [ ] Referral bonuses
- [ ] Emergency pause functionality

## Testing Strategy

1. **Unit Tests**: Test individual functions and edge cases
2. **Integration Tests**: Test VRF callback flows
3. **Scenario Tests**: Test complete airdrop cycles
4. **Gas Analysis**: Optimize for large participant pools
5. **Security Audits**: Check for common vulnerabilities

## Development Phases

### Phase 1: Basic Implementation
- Simple registration and selection
- Basic VRF integration
- Manual winner selection trigger

### Phase 2: Enhanced Features
- Automated time-based phases
- Better error handling
- Gas optimization

### Phase 3: Advanced Features
- Weighted selection algorithms
- Multi-round airdrops
- Dashboard for monitoring
