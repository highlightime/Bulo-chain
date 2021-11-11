const Migrations = artifacts.require("Migrations");
const dotenv = require('dotenv');
dotenv.config();

const sender = process.env.SENDER_ADDRESS;

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Migrations);
};
