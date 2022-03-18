require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
task("deploy", "Deploys the contract", async (taskArgs, hre) => {
  const LimeToken = await hre.ethers.getContractFactory("LimeToken");
  const lime = await LimeToken.deploy();
  await lime.deployed();

  console.log("LimeCoin deployed at address: ", lime.address);
});

task("deploy-mainnet", "Deploys contract on a provided network")
  .addParam("privateKey", "Please provide the private key")
  .setAction(async ({privateKey}) => {
    const deployElectionContract = require("./scripts/deploy-with-params");
    await deployElectionContract(privateKey);
  });

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.7.5",
      },
      {
        version: "0.8.4",
      },
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
    networks: {
      localhost: {
        url: "http://localhost:8545",
      },
      ropsten: {
        url : "https://ropsten.infura.io/v3/dd0b0425f5eb45e78d52071d75f6c147",
        // url: "https://ropsten.infura.io/v3/40c2813049e44ec79cb4d7e0d18de173",
        accounts: ["a425cc857ba34792352eec57f7006098d4a39b1b7b6e6178094655ea628e3af6"]      
      },
  },
},
};

