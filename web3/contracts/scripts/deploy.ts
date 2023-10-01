import { ethers } from "hardhat";

const sepoliaFunctionsRouter = "0xb83E47C2bC239B3bf370bc41e1459A34b41238D0";
const sepoliaCCIPRouter = "0xD0daae2231E9CB96b94C8512223533293C3693Bf";

async function main() {
  const carbonLink = await ethers.deployContract("CarbonLink", [sepoliaFunctionsRouter], {});

  const savedCarbonLink = await carbonLink.waitForDeployment();

  const receiver = await ethers.deployContract("Receiver", [sepoliaCCIPRouter, savedCarbonLink.getAddress()], {});
  const sender = await ethers.deployContract("Sender", [sepoliaCCIPRouter], {});

  await receiver.waitForDeployment();
  await sender.waitForDeployment();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
