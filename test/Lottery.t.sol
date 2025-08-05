// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";

import {Airdrop} from "src/AirdropContract.sol";

contract LotteryTest is Test {
    Airdrop public airdrop;

    function setUp() public {}

    function test_mock() public {
        uint256 test = 1;
        assertEq(test, 1);
    }
}
