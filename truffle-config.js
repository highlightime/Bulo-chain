const HDWalletProvider = require("@truffle/hdwallet-provider");

const { DEPLOYER_ACCOUNT, DEPLOYER_PRIVATE_KEY, PROVIDER_API_KEY, NETWORK } =
  process.env;

if (
  !DEPLOYER_ACCOUNT ||
  !DEPLOYER_PRIVATE_KEY ||
  !PROVIDER_API_KEY ||
  !NETWORK
) {
  throw new Error("haha ! set .env and use docker, you CODE MONKEY🐒 !");
}

// keys
const privateKey = DEPLOYER_PRIVATE_KEY;
const providerApiKey = PROVIDER_API_KEY;

// networks path
const contracts_directory = "./src";

const network = NETWORK || 'ropsten';

const contracts_build_directory = `./networks/${network}/build`;
const migrations_directory = `./networks/${network}/migrations`;

module.exports = {
  contracts_directory,
  contracts_build_directory,
  migrations_directory,
  networks: {
    develop: {
      host: "127.0.0.1",
      port: 8545,
    },
    mainnet: {
      provider: () =>
        new HDWalletProvider(
          privateKey,
          `wss://${network}.infura.io/ws/v3/${providerApiKey}`
        ),
      network_id: 1,
      gasPrice: 100000000000,
      gas: 8000000,
      skipDryRun: true,
    },
    rinkeby: {
      provider: () =>
        new HDWalletProvider(
          privateKey,
          `wss://${network}.infura.io/ws/v3/${providerApiKey}`
        ),
      network_id: 4,
      networkCheckTimeout: 1000000,
      timeoutBlocks: 200,
      addressIndex: 2,
      gas: 6698712,
      gasPrice: 25000000000,
      skipDryRun: true,
    },
    ropsten: {
      provider: function () {
        return new HDWalletProvider(
          privateKey,
          `wss://${network}.infura.io/ws/v3/${providerApiKey}`
        );
      },
      network_id: 3,
      networkCheckTimeout: 3000000,
      pollingInterval: 8000,
      gas: 6000000,
      gasPrice: 10000000000,
      skipDryRun: true,
    },
  },

  mocha: {},

  compilers: {
    solc: {
      version: "0.5.6",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
    },
  },
  db: {
    enabled: false,
  },
};
