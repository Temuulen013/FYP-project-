// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        string photoUrl;
        string bio;
        uint256 voteCount;
    }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 voteIndex;
        string fullName;
    }

    address public electionCommission;
    mapping(address => Voter) public voters;
    mapping(bytes32 => bool) public idUsed;
    Candidate[] private candidates;
    
    bool public electionStarted = false;
    bool public electionEnded = false;

    // --- 📢 EVENTS FOR TRANSPARENCY ---
    // These specific lines allow the website to "listen" to the blockchain
    event VoterRegistered(address indexed voterAddress, string name, uint timestamp);
    event VoteCast(address indexed voterAddress, uint timestamp);
    event ElectionStatusChanged(bool started, bool ended, uint timestamp);

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Only Admin can do this");
        _;
    }

    constructor() {
        electionCommission = msg.sender;
    }

    function registerUser(string memory _name, string memory _govtId) public {
        require(!electionStarted, "Registration Closed");
        require(!voters[msg.sender].isRegistered, "Wallet already has an account");

        bytes32 idHash = keccak256(abi.encodePacked(_govtId));
        require(!idUsed[idHash], "This Government ID is already registered!");

        voters[msg.sender].isRegistered = true;
        voters[msg.sender].fullName = _name;
        idUsed[idHash] = true;

        // Emit Event
        emit VoterRegistered(msg.sender, _name, block.timestamp);
    }

    function vote(uint256 _candidateIndex) public {
        require(electionStarted, "Election Not Active");
        require(!electionEnded, "Election Ended");
        require(voters[msg.sender].isRegistered, "Please Register First");
        require(!voters[msg.sender].hasVoted, "You have already voted");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].voteIndex = _candidateIndex;
        candidates[_candidateIndex].voteCount++;

        // Emit Event (We do NOT emit the candidate index to keep the vote secret!)
        emit VoteCast(msg.sender, block.timestamp);
    }

    // --- ADMIN ---
    function addCandidate(string memory _name, string memory _photoUrl, string memory _bio) public onlyCommissioner {
        require(!electionStarted, "Cannot edit after start");
        candidates.push(Candidate({ name: _name, photoUrl: _photoUrl, bio: _bio, voteCount: 0 }));
    }

    function startElection() public onlyCommissioner { 
        electionStarted = true; electionEnded = false; 
        emit ElectionStatusChanged(true, false, block.timestamp);
    }
    
    function endElection() public onlyCommissioner { 
        electionStarted = false; electionEnded = true; 
        emit ElectionStatusChanged(false, true, block.timestamp);
    }

    // --- VIEWS ---
    function getAllCandidates() public view returns (string[] memory, string[] memory, string[] memory, uint256[] memory) {
        string[] memory names = new string[](candidates.length);
        string[] memory photos = new string[](candidates.length);
        string[] memory bios = new string[](candidates.length);
        uint256[] memory counts = new uint256[](candidates.length);

        for (uint i = 0; i < candidates.length; i++) {
            names[i] = candidates[i].name;
            photos[i] = candidates[i].photoUrl;
            bios[i] = candidates[i].bio;
            if (electionEnded) counts[i] = candidates[i].voteCount;
            else counts[i] = 999999;
        }
        return (names, photos, bios, counts);
    }
    
    function getElectionState() public view returns (bool, bool) { return (electionStarted, electionEnded); }
    function getMyProfile() public view returns (bool registered, bool voted, string memory name) { 
        return (voters[msg.sender].isRegistered, voters[msg.sender].hasVoted, voters[msg.sender].fullName); 
    }
}