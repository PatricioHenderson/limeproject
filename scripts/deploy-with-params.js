const hre = require('hardhat')
const ethers = hre.ethers;

async function deployElectionContract(_privateKey) {
    await hre.run('compile'); // We are compiling the contracts using subtask
    const wallet = new ethers.Wallet(_privateKey, hre.ethers.provider) // New wallet with the privateKey passed from CLI as param
    console.log('Deploying contracts with the account:', wallet.address); // We are printing the address of the deployer
    console.log('Account balance:', (await wallet.getBalance()).toString()); // We are printing the account balance

    const ETHWrapper = await ethers.getContractFactory("ETHWrapper"); // 
    const ethWrapperContract = await ETHWrapper.deploy();
    console.log('Waiting for ETHWrapper deployment...');
    await ethWrapperContract.deployed();

    console.log('ETHWrapper Contract address: ', ethWrapperContract.address);
    console.log('Done!');
}
  
module.exports = deployWETHContract;