var BoredPetsNFT = artifacts.require("BoredPetsNFT");
var Marketplace = artifacts.require("Marketplace");

module.exports = async function(deployer) {

  // Because BoredPetsNFT requires the Marketplace contract address, order matters here!
  await deployer.deploy(Marketplace);
  const marketplace = await Marketplace.deployed();
  await deployer.deploy(BoredPetsNFT, marketplace.address);
}
