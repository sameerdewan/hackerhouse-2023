import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import '@chainlink/contracts'
import '@openzeppelin/hardhat-upgrades'

const config: HardhatUserConfig = {
  solidity: '0.8.19',

  networks: {
    mumbai: {
      url: 'https://polygon-mumbai.g.alchemy.com/v2/tCbwTAqlofFnmbVORepuHNcsrjNXWdRJ',
      accounts: [process.env.PRIVATE_KEY || ''],
    },
    sepolia: {
      url: '', // TODO: add sepolia node url
      accounts: [process.env.PRIVATE_KEY || ''],
    },
  },
  defaultNetwork: 'mumbai',
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}

export default config
