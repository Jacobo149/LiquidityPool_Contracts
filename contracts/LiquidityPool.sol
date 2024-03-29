// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./TokenA.sol";
import "./TokenB.sol";


contract LiquidityPool {


    // Tokens
    TokenA public tokenA;
    TokenB public tokenB;

    // Liquidity Tokens
    mapping(address => uint) public liquidity;

    // Interest Rate
    uint public interestRate = 10; // 10% interest rate
    uint public lastUpdateTime;

    // Events
    event AddLiquidity(address indexed user, uint amountA, uint amountB);
    event RemoveLiquidity(address indexed user, uint amountA, uint amountB);
    event SwapAforB(address indexed user, uint amountA, uint amountB);
    event SwapBforA(address indexed user, uint amountA, uint amountB);
    event TokensApproved(address indexed user, uint amountA, uint amountB);
    event TokensStaked(address indexed user, uint amountA, uint amountB);
    event InterestDistribution(address indexed user, uint amountA, uint amountB);

    // Pool Variables
    uint TokenAStaked;
    uint TokenBStaked;
    uint TokenATotal;
    uint TokenBTotal;

    // Constructor assumes Tokena and TokenB are already deployed
    constructor(TokenA _tokenA, TokenB _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        lastUpdateTime = block.timestamp;
    }
    
    // Add Liquidity to Pool
    function addLiquidity(uint _amountA, uint _amountB) public {
        // Check for correct user amounts
        require(tokenA.balanceOf(msg.sender) >= _amountA, "Insufficient TokenA Balance");

        require(tokenB.balanceOf(msg.sender) >= _amountB, "Insufficient TokenB Balance");

        // Transfer Tokens to Pool
        tokenA.transferFrom(msg.sender, address(this), _amountA);
        tokenB.transferFrom(msg.sender, address(this), _amountB);

        // Update Pool Variables
        TokenATotal += _amountA;
        TokenBTotal += _amountB;

        // Mint Liquidity Tokens
        liquidity[msg.sender] += _amountA + _amountB;

        emit AddLiquidity(msg.sender, _amountA, _amountB);
    }

    // Remove Liquidity from Pool
    function removeLiquidity(uint _amount) public {
        require(liquidity[msg.sender] >= _amount, "Insufficient balance");
        

        // Continue with the rest of the function
        liquidity[msg.sender] -= _amount * 2;

        // Update Pool Variables
        require(TokenATotal >= _amount, "Insufficient TokenA in Pool");
        require(TokenBTotal >= _amount, "Insufficient TokenB in Pool");
        tokenA.transfer(msg.sender, _amount);
        tokenB.transfer(msg.sender, _amount);

        emit RemoveLiquidity(msg.sender, _amount, _amount);
    }

    // Swap TokenA for TokenB
    function swapAforB(uint _amount) public {
        require(tokenA.balanceOf(msg.sender) >= _amount, "Insufficient TokenA Balance");
        require(TokenATotal >= _amount, "Insufficient TokenA in Pool");

        TokenATotal += _amount;

        // Transfer Tokens to Pool
        tokenA.transferFrom(msg.sender, address(this), _amount);

        TokenBTotal -= _amount;

        // Transfer Tokens to User
        tokenB.transfer(msg.sender, _amount);

        emit SwapAforB(msg.sender, _amount, _amount);
    }

    function swapBforA(uint _amount) public {
        require(tokenB.balanceOf(msg.sender) >= _amount, "Insufficient TokenB Balance");
        require(TokenBTotal >= _amount, "Insufficient TokenB in Pool");

        TokenBTotal += _amount;

        // Transfer Tokens to Pool
        tokenB.transferFrom(msg.sender, address(this), _amount);


        TokenATotal -= _amount;

        // Transfer Tokens to User
        tokenA.transfer(msg.sender, _amount);

        emit SwapBforA(msg.sender, _amount, _amount);
    }

    function stakeTokenA(uint _amount) public {

        require(tokenA.balanceOf(msg.sender) >= _amount, "Insufficient TokenA Balance");
        emit TokensApproved(msg.sender, _amount, 0);

        TokenATotal += _amount;
        TokenAStaked += _amount;

        tokenA.transferFrom(msg.sender, address(this), _amount);

        emit TokensStaked(msg.sender, _amount, 0);

    }

    function stakeTokenB(uint _amount) public {
        require(tokenB.balanceOf(msg.sender) >= _amount, "Insufficient TokenB Balance");
        emit TokensApproved(msg.sender, 0, _amount);

        TokenBTotal += _amount;
        TokenBStaked += _amount;

        tokenB.transferFrom(msg.sender, address(this), _amount);

        emit TokensStaked(msg.sender, 0, _amount);
    }

    // Get Pool Variables
    function getPool() public view returns(uint, uint) {
        return (TokenATotal, TokenBTotal);
    }
    
    // Get Liquidity Tokens
    function getLiquidity(address _user) public view returns(uint) {
        return liquidity[_user];
    }

    function approveToken(address _spender, uint256 _amount) public {
            ERC20(tokenA).approve(_spender, _amount); // Call the approve function on the token contract instance
            approveToken(_spender, _amount);

        }

    function stakeInterest() public {
        uint elapsedTime = block.timestamp - lastUpdateTime; // Calculate elapsed time since the last update

        // Calculate interest for TokenA and TokenB
        uint tokenAInterest = (TokenAStaked * interestRate * elapsedTime) / (365 * 24 * 60 * 60);
        uint tokenBInterest = (TokenBStaked * interestRate * elapsedTime) / (365 * 24 * 60 * 60);

        // Distribute interest to stakers in the form of liquidity tokens
        distributeLiquidityTokens(msg.sender, tokenAInterest + tokenBInterest);

        // Update the last update time
        lastUpdateTime = block.timestamp;

        emit InterestDistribution(msg.sender, tokenAInterest, tokenBInterest);
    }


     function distributeLiquidityTokens(address _staker, uint _interest) internal {
        if (_interest > 0) {
            // Distribute liquidity tokens directly to the staker
            liquidity[_staker] += _interest;
        }
    }


}