🗳️ Blockchain Election Voting System
A decentralized voting application built with Solidity, Hardhat, and Ethers.js.

📌 Project Overview
This project is a blockchain-based voting system designed to ensure transparency and security in elections. It features a dashboard for the Election Commission (Admin) to manage candidates and an interface for voters to cast their ballots securely via MetaMask.

🛠️ Tech Stack
Smart Contract: Solidity

Development Environment: Hardhat (Local Blockchain)

Frontend: HTML/CSS/JavaScript

Library: Ethers.js (v6)

Wallet: MetaMask

🚀 Getting Started (Development Setup)
Follow these steps in order to get the project running on your local machine.

1. Prerequisites
Ensure you have the following installed:

Node.js (v18+ recommended)

Git

MetaMask Browser Extension

2. Installation
Clone the repository and install the dependencies:

Bash

git clone <your-repo-link>
cd election-voting
npm install
3. Local Blockchain Setup
In a new terminal, start the Hardhat node:

Bash

npm run chain
Note: Keep this terminal open. Hardhat will provide 20 test accounts. Copy the Private Key of Account #0 and import it into your MetaMask.

4. Deploy the Smart Contract
In a second terminal, deploy the contract to the local network:

Bash

npm run deploy
This command deploys the contract and automatically updates the frontend/Voting.json file with the new contract address and ABI.

5. Launch the Frontend
In a third terminal, start the local web server:

Bash

npm run dev
Open your browser to http://localhost:3000.

🦊 MetaMask Configuration
To interact with the system, configure MetaMask with these settings:

Network Name: Hardhat Local

New RPC URL: http://127.0.0.1:8545

Chain ID: 31337

Currency Symbol: ETH

⚠️ Important: If you restart the Hardhat node, you must reset your MetaMask account (Settings > Advanced > Clear Activity Tab Data) to avoid "Nonce" errors.

📂 Project Structure
contracts/: Contains the Solidity smart contract (Voting.sol).

scripts/: Deployment scripts for Hardhat.

frontend/: The web interface and Voting.json configuration.

hardhat.config.js: Hardhat network and compiler settings.

🔄 Syncing Between Devices (Git Workflow)
Before switching between your PC and Laptop, use these commands:

On the machine you are leaving:

Bash

git add .
git commit -m "Describe your changes"
git push origin hardhat-migration
On the machine you are starting on:

Bash

git pull origin hardhat-migration
npm install   # If it's the first time on this machine
