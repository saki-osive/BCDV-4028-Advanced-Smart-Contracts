const BridgeAtoB = artifacts.require("BridgeAtoB");
const TokenA = artifacts.require("TokenA");
const TokenB = artifacts.require("TokenB");

contract('Bridge A to B', (accounts) => {
  let bridge;
  let tokenA;
  let tokenB;

  before(async () => {
    tokenA = await TokenA.new({ from: accounts[0] });
    tokenB = await TokenB.new({ from: accounts[0] });
    bridge = await BridgeAtoB.new(tokenA.address, tokenB.address, { from: accounts[0] });
  });

  it("should lock and release tokens", async () => {
    const amount = 100;

    await tokenA.approve(bridge.address, amount, { from: accounts[0] });
    await bridge.lockTokens(amount, { from: accounts[0] });
    await bridge.releaseTokens(accounts[1], amount, { from: accounts[0] });

    const account1Balance = await tokenB.balanceOf(accounts[1]);
    assert.equal(account1Balance.toNumber(), amount, "Incorrect balance after release");
  });
});
