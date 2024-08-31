// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
 contract etherStaking {
    constructor() {
        
    }
    struct Stake {
        uint stakingAmount;
        string stakeDuration;
        bool isStake;
    }
    mapping (address => Stake) userStake

    function userStakeDeposit (uint _stakingAmount, string _stakeDuration) external payable  {
         require(msg.sender != address(0), "zero addres detected");

        require(_stakingAmount > 0, "can't deposit zero");

        Stake memory _staker = userStake[msg.sender];
        if(_staker.isStake == true) {
            revert("User already staked");
        }

        userStake[msg.sender] = Stake(_stakingAmount, _stakeDuration, true); 

    }

 }