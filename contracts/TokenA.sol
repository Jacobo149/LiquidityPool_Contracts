// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20 {
    // Constructor: Set the token name, symbol, and initial supply
    constructor() ERC20("TokenA", "TKA") {
        _mint(msg.sender, 1000000000000000000000000); // Mint 1,000 tokens (adjust the number of zeros based on your desired supply)
    }
}
