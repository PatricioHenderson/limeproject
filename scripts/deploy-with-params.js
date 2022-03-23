const hre = require('hardhat')
const ethers = hre.ethers;

async function deployLimeContract(_privateKey) {
    await hre.run('compile'); // We are compiling the contracts using subtask
    const wallet = new ethers.Wallet(_privateKey, hre.ethers.provider) // New wallet with the privateKey passed from CLI as param
    console.log('Deploying contracts with the account:', wallet.address); // We are printing the address of the deployer
    console.log('Account balance:', (await wallet.getBalance()).toString()); // We are printing the account balance

    const LimeToken = await ethers.getContractFactory("LimeToken"); // 
    const lime = await LimeToken.deploy();
    console.log('Waiting for LimeToken deployment...');
    await lime.deployed();

    console.log('LimeToken Contract address: ', lime.address);
    console.log('Done!');
}
module.exports = deployLimeContract;
