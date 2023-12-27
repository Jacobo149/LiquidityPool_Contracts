// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./TokenA.sol";
import "./TokenB.sol";

contract LiquidityPool {

    // Struct to keep track of Liquidity Pool
    struct Pool {
        uint TokenAStaked;
        uint TokenBStaked;
        uint TokenATotal;
        uint TokenBTotal;
    }

    // Create and Set Pool Values
    Pool public myPool;

    function setPool(){
        myPool = Pool(0, 0, 0, 0);
    }
    
    // Create Tokens

    // Mint Tokens to Account

    // Stake Tokens

    // Swap TokenA for TokenB

    // Swap TokenB for TokenA

    
}