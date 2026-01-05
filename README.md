Markdown

# 🗳️ SecureVote: Blockchain-Based Voting System

A decentralized election system built on the Ethereum blockchain (Ganache) that ensures transparency, security, and immutability. This project features a full Voter Dashboard, an Admin Portal, and a Live Blockchain Audit Log.

## ✨ Features

- **Decentralized Voting:** Votes are stored on the blockchain and cannot be altered.
- **Identity Verification:** Users register with a Name and Government ID.
- **Admin Control:** Dedicated portal to add candidates and control election status (Start/End).
- **Transparency:** A live "Audit Log" shows every transaction (Registration/Vote) in real-time.
- **Double-Voting Protection:** One ID = One Vote. Smart Contract enforced.
- **Results:** Automatic winner calculation and official profile generation.

## 🛠️ Technology Stack

- **Frontend:** HTML5, CSS3 (Modern UI), JavaScript (Ethers.js)
- **Backend:** Solidity (Smart Contracts)
- **Blockchain:** Ganache (Local Ethereum Testnet)
- **Wallet:** MetaMask (Browser Extension)

---

## 🚀 Installation Guide

### Prerequisites
1.  **Node.js** installed (v14 or higher).
2.  **MetaMask** extension installed in your browser.
3.  **Git** installed.

### 1. Clone the Repository
```bash
git clone [https://github.com/YourName/voting-system-fyp.git](https://github.com/YourName/voting-system-fyp.git)
cd voting-system-fyp
2. Install Dependencies
Bash

npm install
3. Start Local Blockchain
Open a new terminal and run:

Bash

npm run chain
# OR
npx ganache --chainId 1337
Keep this terminal running!

4. Deploy Smart Contract
Open a second terminal and run:

Bash

node deploy.js
Copy the "Contract Address" shown in the terminal if needed, but the app should detect it automatically.

🎮 Usage Guide
A. Setup MetaMask
Open MetaMask -> Click the Network Dropdown -> Add Network.

Add a network manually:

Network Name: Localhost 8545

RPC URL: http://127.0.0.1:8545

Chain ID: 1337

Currency Symbol: ETH

Import Accounts: Import the "Private Keys" from your Ganache terminal to get free test ETH.

Important: If you restart Ganache, go to Settings > Advanced > Clear activity tab data in MetaMask to avoid errors.

B. Admin Portal (Setup Election)
Open frontend/admin.html in your browser (or navigate via the dashboard).

Login with the first account (Admin Account).

Add Candidates: Enter Name, Photo URL, and Bio.

Start Election: Click the "Start Election" button.

C. Voter Dashboard (Voting)
Open frontend/index.html.

Register: Enter your Name and a unique ID (e.g., ID-101).

Vote: Browse the ballot and click "Vote".

Transparency: Check the bottom of the Admin page to see your vote recorded on the blockchain live.

📂 Project Structure
voting-system-fyp/
├── contracts/          # Solidity Smart Contracts (Voting.sol)
├── frontend/           # The Website Files
│   ├── index.html      # Voter Dashboard (Login/Vote)
│   ├── admin.html      # Admin Control Center
│   └── president.html  # Winner Profile Page
├── deploy.js           # Script to put contract on blockchain
├── package.json        # Project settings & dependencies
└── README.md           # This file
⚠️ Troubleshooting
"Nonce too high" Error in MetaMask: This happens when you restart the blockchain.

Fix: Open MetaMask > Settings > Advanced > Clear activity tab data.

"Contract not found" / Loading forever:

Make sure you ran node deploy.js.

Make sure you are on the correct network (Localhost 8545).

University Final Year Project (2025)


### ✅ Final Step
1.  Save this file.
2.  Run `git add README.md`
3.  Run `git commit -m "Added documentation"`
4.  Run `git push`

Your repository is now professional and ready for submission!
