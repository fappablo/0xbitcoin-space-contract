async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  The0xBitcoinSpace = await ethers.getContractFactory("The0xBitcoinSpace");
  the0xBitcoinSpace = await The0xBitcoinSpace.deploy();

  console.log("the0xBitcoinSpace address:", the0xBitcoinSpace.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });