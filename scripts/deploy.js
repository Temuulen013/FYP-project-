const hre = require('hardhat');
const fs = require('fs');
const path = require('path');

async function main() {
  console.log('🚀 Starting Deployment...');

  // 1. Get the Contract Factory
  const Voting = await hre.ethers.getContractFactory('Voting');

  // 2. Deploy the Contract
  const voting = await Voting.deploy();
  await voting.waitForDeployment();

  const address = await voting.getAddress();
  console.log('✅ Contract Deployed to:', address);

  // 3. Save the Config for the Website
  // We use path.join(__dirname, "..", ...) to go out of 'scripts' and into 'frontend'
  const data = {
    address: address,
    abi: JSON.parse(voting.interface.formatJson()),
  };

  const frontendPath = path.join(__dirname, '..', 'frontend', 'Voting.json');

  // Create frontend folder if it doesn't exist (safety check)
  if (!fs.existsSync(path.join(__dirname, '..', 'frontend'))) {
    fs.mkdirSync(path.join(__dirname, '..', 'frontend'));
  }

  fs.writeFileSync(frontendPath, JSON.stringify(data, null, 2));
  console.log(`📂 Config saved to: ${frontendPath}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
