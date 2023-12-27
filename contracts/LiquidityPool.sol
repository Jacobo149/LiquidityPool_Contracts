// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./TokenA.sol";
import "./TokenB.sol";


contract LiquidityPool {

    // TODO: May Need A Mapping to keep track of how many coins each account has

    // Tokens
    TokenA public tokenA;
    TokenB public tokenB;

    // Liquidity Tokens
    mapping(address => uint) public balanceOf;

    // Pool Variables
    uint TokenAStaked;
    uint TokenBStaked;
    uint TokenATotal;
    uint TokenBTotal;

    // Constructor assumes Tokena and TokenB are already deployed
    constructor(TokenA _tokenA, TokenB _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }
    
    // Add Liquidity to Pool
    function addLiquidity(uint _amountA, uint _amountB) {
        // Transfer Tokens to Pool
        tokenA.transferFrom(msg.sender, address(this), _amountA);
        tokenB.transferFrom(msg.sender, address(this), _amountB);

        // Update Pool Variables
        TokenATotal += _amountA;
        TokenBTotal += _amountB;

        // Mint Liquidity Tokens
        balanceOf[msg.sender] += _amountA + _amountB;
    }

    // Mint Tokens to Account

    // Stake Tokens

    // Swap TokenA for TokenB

    // Swap TokenB for TokenA

    
}