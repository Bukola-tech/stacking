// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20Staking {
    struct Stake {
        uint stakingAmount;
        uint stakeDuration;
        uint stakingOnset;
        bool isStake;
    }

    mapping(address => Stake) public userStake;

    function userStakeDeposit(address tokenAddress, uint _stakingAmount, uint _stakeDuration) external {
        require(msg.sender != address(0), "Zero address detected");
        require(_stakingAmount > 0, "Can't deposit zero");

        uint256 _userTokenBalance = IERC20(tokenAddress).balanceOf(msg.sender);
        require(_userTokenBalance >= _stakingAmount, "Insufficient amount");

        Stake memory _staker = userStake[msg.sender];
        require(!_staker.isStake, "User already staked");

        uint _stakingOnset = block.timestamp;
        uint _stakeDurationPeriod = _stakeDuration * 30 days;

        // Transfer tokens from the user to the contract
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), _stakingAmount), "Token transfer failed");

        userStake[msg.sender] = Stake(_stakingAmount, _stakeDurationPeriod, _stakingOnset, true);
    }

    function calculateReward(address tokenAddress, address _staker) public view returns (uint) {
        Stake memory stake = userStake[_staker];
        require(stake.isStake, "No active stake");

        if (block.timestamp >= stake.stakingOnset + stake.stakeDuration) {
            uint reward = (stake.stakingAmount * 20) / 100;
            return stake.stakingAmount + reward;
        } else {
            return stake.stakingAmount;
        }
    }

    function withdrawStake(address tokenAddress) external {
        Stake memory stake = userStake[msg.sender];
        require(stake.isStake, "No active stake");
        require(block.timestamp >= stake.stakingOnset + stake.stakeDuration, "Staking period not yet over");

        uint reward = (stake.stakingAmount * 20) / 100;
        uint totalAmount = stake.stakingAmount + reward;

        // Reset the user's stake
        delete userStake[msg.sender];

        // Transfer the total amount (original stake + reward) back to the user
        require(IERC20(tokenAddress).transfer(msg.sender, totalAmount), "Token transfer failed");
    }

    function checkBalance(address tokenAddress) external view returns (uint) {
        return calculateReward(tokenAddress, msg.sender);
    }
}
