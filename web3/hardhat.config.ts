import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import '@chainlink/contracts'
import '@openzeppelin/hardhat-upgrades'

const config: HardhatUserConfig = {
  solidity: '0.8.19',

  networks: {
    sepolia: {
      url: '', // TODO: add sepolia node url
      accounts: [process.env.PRIVATE_KEY || ''],
    },
  },
  defaultNetwork: 'sepolia',
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}

export default config
