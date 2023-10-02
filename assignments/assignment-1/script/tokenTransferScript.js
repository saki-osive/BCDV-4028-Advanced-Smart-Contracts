const Web3 = require('web3');
const contract = require('truffle-contract');
const web3 = new Web3('http://localhost:7545'); // Replace with your Ethereum RPC URL

// Load contract artifacts
const BridgeAtoBArtifact = require('./build/contracts/BridgeAtoB.json');
const TokenAArtifact = require('./build/contracts/TokenA.json');
const TokenBArtifact = require('./build/contracts/TokenB.json');

// Create contract instances
const BridgeAtoB = contract(BridgeAtoBArtifact);
const TokenA = contract(TokenAArtifact);
const TokenB = contract(TokenBArtifact);

// Set the web3 provider for the contract instances
BridgeAtoB.setProvider(web3.currentProvider);
TokenA.setProvider(web3.currentProvider);
TokenB.setProvider(web3.currentProvider);

const senderAddress = '0xB872586aD1DCb0e2B72385F44E18A32505403367'; // sender's address
const receiverAddress = '0xcF74e7A57c3F95b662eC9cC81fe8AC64e63Fb6dF'; // receiver's address
const amountToTransfer = web3.utils.toWei('1', 'ether');

async function sendTokens() {
    // Get contract instances
    const bridgeAtoBInstance = await BridgeAtoB.deployed();
    const tokenAInstance = await TokenA.deployed();
    const tokenBInstance = await TokenB.deployed();

    // Approve token transfer
    await tokenAInstance.approve(bridgeAtoBInstance.address, amountToTransfer, { from: senderAddress });

    // Lock tokens
    await bridgeAtoBInstance.lockTokens(amountToTransfer, { from: senderAddress });

    // Wait for the bridge to process the transaction (depends on your implementation)

    // Release tokens on the other chain
    await bridgeAtoBInstance.releaseTokens(receiverAddress, amountToTransfer, { from: senderAddress });
}

sendTokens();
