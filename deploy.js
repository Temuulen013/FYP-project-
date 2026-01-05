const fs = require('fs');
const path = require('path');
const solc = require('solc');
const { ethers } = require('ethers');

async function main() {
  // 1. Load the contract source code
  const contractPath = path.resolve(__dirname, 'contracts', 'Voting.sol');
  const source = fs.readFileSync(contractPath, 'utf8');

  // 2. Compile the Contract
  const input = {
    language: 'Solidity',
    sources: { 'Voting.sol': { content: source } },
    settings: { outputSelection: { '*': { '*': ['*'] } } },
  };

  console.log('⏳ Compiling Smart Contract...');
  const output = JSON.parse(solc.compile(JSON.stringify(input)));

  // Check for compilation errors
  if (output.errors) {
    let hasError = false;
    output.errors.forEach((err) => {
      console.error(err.formattedMessage);
      if (err.severity === 'error') hasError = true;
    });
    if (hasError) return;
  }

  const contractFile = output.contracts['Voting.sol']['Voting'];
  const abi = contractFile.abi;
  const bytecode = contractFile.evm.bytecode.object;

  // 3. Connect to Ganache
  // Note: We use the URL you set in your "chain" script
  const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545');
  const signer = await provider.getSigner(); // Uses the first account (Admin)

  // 4. Deploy
  console.log(`🚀 Deploying from account: ${await signer.getAddress()}`);
  const factory = new ethers.ContractFactory(abi, bytecode, signer);
  const contract = await factory.deploy(); // Deploys the contract

  await contract.waitForDeployment();
  const address = await contract.getAddress();

  console.log(`✅ Contract Deployed to: ${address}`);

  // 5. Save the address and ABI for the website to use
  const artifact = { address, abi };
  const frontendPath = path.resolve(__dirname, 'frontend', 'Voting.json');
  fs.writeFileSync(frontendPath, JSON.stringify(artifact, null, 2));
  console.log('📄 Artifact saved to frontend/Voting.json');
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
