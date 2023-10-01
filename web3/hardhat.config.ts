import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const infuraURL = "https://sepolia.infura.io/v3/df4de1f306044440bf0e4843d8ff667b";
const privateKey = "cbee8ce12491a420e5f6985be94c95a4305d375d63f7aab74c2148ffb7bf3492"; // DEMO
const etherscanKey = "RTKTPPWTQKQ6UNTVFRG6VWFN3SCI281IJP";

const config: HardhatUserConfig = {
  solidity: '0.8.19',

  networks: {
    sepolia: {
      url: infuraURL, // TODO: add sepolia node url
      accounts: [privateKey],
    },
  },
  defaultNetwork: 'sepolia',
  etherscan: {
    apiKey: etherscanKey,
  },
}

export default config
