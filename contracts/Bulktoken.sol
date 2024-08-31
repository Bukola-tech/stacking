// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BulksToken is ERC20 {
    constructor() ERC20("Bulks", "BK") {
        // Mint 1000 * 10^18 tokens to the deployer's address
        _mint(msg.sender, 1000 * 10**18);
    }
}


// 0xC7a14237ED47a60Cc7c9004f4225A60A25Ae61F9