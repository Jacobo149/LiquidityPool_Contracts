// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./TokenA.sol";
import "./TokenB.sol";


contract LiquidityPool {


    // Tokens
    TokenA public tokenA;
    TokenB public tokenB;

    // Liquidity Tokens
    mapping(address => uint) public balanceOf;

    // Pool Variables
    //uint TokenAStaked;
    //uint TokenBStaked;
    uint TokenATotal;
    uint TokenBTotal;

    // Constructor assumes Tokena and TokenB are already deployed
    constructor(TokenA _tokenA, TokenB _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }
    
    // Add Liquidity to Pool
    function addLiquidity(uint _amountA, uint _amountB) public {
        // Transfer Tokens to Pool
        tokenA.transferFrom(msg.sender, address(this), _amountA);
        tokenB.transferFrom(msg.sender, address(this), _amountB);

        // Update Pool Variables
        TokenATotal += _amountA;
        TokenBTotal += _amountB;

        // Mint Liquidity Tokens
        balanceOf[msg.sender] += _amountA + _amountB;
    }

    // Remove Liquidity from Pool
    // Remove Liquidity from Pool
    function removeLiquidity(uint _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");

        // Continue with the rest of the function
        balanceOf[msg.sender] -= _amount;
        // Assume pool has enough tokens to cover the amount (Because the amount in is the exact amount out)
        // Make dynamic in future
        tokenA.transfer(msg.sender, _amount);
        tokenB.transfer(msg.sender, _amount);
    }

    // Swap TokenA for TokenB
    function SwapAforB(uint _amount) public {
        // Transfer Tokens to Pool
        tokenA.transferFrom(msg.sender, address(this), _amount);

        TokenATotal += _amount;

        // Transfer Tokens to User
        tokenB.transfer(msg.sender, _amount);

        TokenBTotal -= _amount;
    }

    function SwapBforA(uint _amount) public {
        // Transfer Tokens to Pool
        tokenB.transferFrom(msg.sender, address(this), _amount);

        TokenBTotal += _amount;

        // Transfer Tokens to User
        tokenA.transfer(msg.sender, _amount);

        TokenATotal -= _amount;
    }
    
}