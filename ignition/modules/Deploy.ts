// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

// const Erc20StakingHubModule = buildModule("Erc20StakingHubModule", (m) => {
//   const ERC20Staking = m.contract("ERC20Staking");

//   return { ERC20Staking };
// });

// export default Erc20StakingHubModule;


const EtherStakingHubModule = buildModule("EtherStakingHubModule", (m) => {
  const EtherStaking = m.contract("EtherStaking");

  return { EtherStaking };
});

export default EtherStakingHubModule;


//Erc20StakingHubModule#ERC20Staking - 0x94Eb14e95348E7cA8997c44F34F96b30F4086252
//EtherStakingHubModule#EtherStaking - 0xD9007969828AdDE9c8A019c667143A6cE1Cc02B6

