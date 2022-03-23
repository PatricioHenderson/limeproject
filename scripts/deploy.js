const hre = require('hardhat')
const ethers = hre.ethers;

async function deployLimeContract {
    await hre.run('compile'); // We are compiling the contracts using subtask
    const [deployer] = await ethers.getSigners(); // We are getting the deployer

    console.log('Deploying contracts with the account:', deployer.address); // We are printing the address of the deployer
    console.log('Account balance:', (await deployer.getBalance()).toString()); // We are printing the account balance

    const BLimeToken = await ethers.getContractFactory("BLimeToken"); //
    const bLimeTokenContract = await BLimeToken.deploy();
    console.log('Waiting for BLimeToken deployment...');
    await bLimeTokenContract.deployed();

    console.log('BLimeToken Contract address: ', bLimeTokenContract.address);
    console.log('Done!');
}

module.exports = deployLimeContract;

