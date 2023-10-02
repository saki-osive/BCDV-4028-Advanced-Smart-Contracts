const BridgeAtoB = artifacts.require("BridgeAtoB");
const BridgeBtoA = artifacts.require("BridgeBtoA");
const TokenA = artifacts.require("TokenA");
const TokenB = artifacts.require("TokenB");

module.exports = async function (deployer, network, accounts) {

  await deployer.deploy(TokenA);
  await deployer.deploy(TokenB);

  // Deployed instances of TokenA and TokenB
  const tokenAInstance = await TokenA.deployed();
  const tokenBInstance = await TokenB.deployed();

  // Deploy BridgeAtoB and BridgeBtoA contracts, passing the addresses of TokenA and TokenB
  await deployer.deploy(BridgeAtoB, tokenAInstance.address, tokenBInstance.address);
  await deployer.deploy(BridgeBtoA, tokenAInstance.address, tokenBInstance.address);

};