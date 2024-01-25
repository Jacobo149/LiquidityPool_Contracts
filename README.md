# LiquidityPool_Contracts
Set of contracts to mimic Liquidity Pool functionality.  
Two ERC20 standard token contracts are created which are then used to drive the liquidity pool economy.

## Features
- Adding/Removing liquidity for both tokens
- Staking with interest
- Thorough events/errors for front end integration


## Compilation + Deployment Notes
To interact with contracts, use the preferred Ethereum Smart Contract software.  
Ensure you compile and deploy token contracts (TokenA, TokenB) before the liquidity pool contract.

## Funtionality
- `constructor(_tokenA , _tokenB)`: Create a new LiquidityPool.
    - `_tokenA`: Token to be used in liquidity pool
    - `_tokenB`: Token to be used in liquidity pool

- `addLiquidity(_amountA, _amountB)` : Add both tokens as liquidity and receive liquidity tokens
    - `_amountA` : Amount of tokenA added to pool
    - `_amountB` : Amount of tokenB added to pool

- `removeLiquidity(_amount)` : Removes equal amount of tokenA and tokenB from pool
    - `_amount` : Amount of tokens to be removed

- `swapAforB(_amount)` : Swaps TokenA for TokenB
    - `_amount` : Amount of tokens to be swapped

- `swapBforA(_amount)` : Swaps TokenB for TokenA
    - `_amount` : Amount of tokens to be swapped

- `stakeTokenA(_amount)` : Stakes TokenA
    - `_amount` : Amount of TokenA to be staked

- `stakeTokenB(_amount)` : Stakes TokenB
    - `_amount` : Amount of TokenB to be staked

- `stakeInterest()` : Calculates and distributes interest liquidity tokens

- `distributeLiquidityTokens(_staker, _interest)` : Distributes interest liquidity tokens to staker
    - `_staker` : Address to send liquidity tokens
    - `_interest` : Calculated interest to distribute

- `getPool()` : Returns pool tokenA/tokenB liquidity

- `getLiquidity(_user)` : Returns liquidity tokens of specified address
    - `_user` : Address for returning liquidity 

- `approveToken(_spender, _amount)` : Approves Spending of tokenA or tokenB
    - `_spender` : Address sending tokens
    - `_amount` : Amount of tokens being approved


## Current TODO
Make Liquidity Token ERC20  
Add Error events for error feedback on the Dapp client   
Market behavior for tokens
