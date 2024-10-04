// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract EtherStaking {
    struct Stake {
        uint stakingAmount;
        uint stakeDuration;
        uint stakingOnset;
        bool isStake;
    }

    mapping(address => Stake) userStake;


    function userStakeDeposit(uint _stakingAmount, uint _stakeDuration) external payable {
        require(msg.sender != address(0), "Zero address detected");
        require(_stakingAmount > 0, "Can't deposit zero");

        Stake memory _staker = userStake[msg.sender];
        require(!_staker.isStake, "User already staked");

        uint _stakingOnset = block.timestamp;
        uint _stakeDurationPeriod = _stakeDuration * 30 days;

        userStake[msg.sender] = Stake(_stakingAmount, _stakeDurationPeriod, _stakingOnset, true); 
    }

    function calculateReward(address _staker) public view returns (uint) {
        Stake memory stake = userStake[_staker];
        require(stake.isStake, "No active stake");

        if (block.timestamp >= stake.stakingOnset + stake.stakeDuration) {
            uint reward = (stake.stakingAmount * 20) / 100;
            return stake.stakingAmount + reward;
        } else {
            return stake.stakingAmount;
        }
    }

    function withdrawStake() external {
        Stake memory stake = userStake[msg.sender];
        require(stake.isStake, "No active stake");
        require(block.timestamp >= stake.stakingOnset + stake.stakeDuration, "Staking period not yet over");


        uint reward = (stake.stakingAmount * 20) / 100;
        uint totalAmount = stake.stakingAmount + reward;

        delete userStake[msg.sender];

        payable(msg.sender).transfer(totalAmount);
    }

    function checkBalance() external view returns (uint) {
        return calculateReward(msg.sender);
    }
}



 