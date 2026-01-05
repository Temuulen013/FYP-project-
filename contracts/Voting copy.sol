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
    }

    address public electionCommission;
    mapping(address => Voter) public voters;
    mapping(address => bool) public isPending; // True if waiting for approval
    
    Candidate[] private candidates;
    address[] private pendingList; // History of all requests

    bool public electionStarted = false;
    bool public electionEnded = false;

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Only Election Commission can do this");
        _;
    }

    constructor() {
        electionCommission = msg.sender;
    }

    // --- ADMIN ACTIONS ---

    function addCandidate(string memory _name, string memory _photoUrl, string memory _bio) public onlyCommissioner {
        require(!electionStarted, "Cannot add candidates after start");
        candidates.push(Candidate({
            name: _name,
            photoUrl: _photoUrl,
            bio: _bio,
            voteCount: 0
        }));
    }

    // APPROVE: Allow them to vote
    function approveVoter(address _voter) public onlyCommissioner {
        require(isPending[_voter], "User did not request access");
        voters[_voter].isRegistered = true;
        isPending[_voter] = false; // Remove from pending
    }

    // NEW: REJECT - Remove them from pending without giving access
    function rejectVoter(address _voter) public onlyCommissioner {
        require(isPending[_voter], "User did not request access");
        isPending[_voter] = false; // Simply remove "Pending" status
    }

    function startElection() public onlyCommissioner {
        electionStarted = true;
        electionEnded = false;
    }

    function endElection() public onlyCommissioner {
        electionStarted = false;
        electionEnded = true;
    }

    // --- VOTER ACTIONS ---

    function requestRegistration() public {
        require(!electionStarted, "Registration is closed");
        require(!voters[msg.sender].isRegistered, "You are already registered");
        require(!isPending[msg.sender], "Request already sent.");

        pendingList.push(msg.sender);
        isPending[msg.sender] = true;
    }

    function vote(uint256 _candidateIndex) public {
        require(electionStarted, "Election is not active");
        require(!electionEnded, "Election has ended");
        require(voters[msg.sender].isRegistered, "You are NOT verified.");
        require(!voters[msg.sender].hasVoted, "You have already voted.");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].voteIndex = _candidateIndex;
        candidates[_candidateIndex].voteCount++;
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
            if (electionEnded) {
                counts[i] = candidates[i].voteCount;
            } else {
                counts[i] = 999999;
            }
        }
        return (names, photos, bios, counts);
    }

    function getPendingList() public view returns (address[] memory) {
        return pendingList;
    }

    function isPendingVoter(address _voter) public view returns (bool) {
        return isPending[_voter];
    }

    function getMyStatus() public view returns (bool registered, bool voted, bool pending) {
        return (voters[msg.sender].isRegistered, voters[msg.sender].hasVoted, isPending[msg.sender]);
    }
    
    function getElectionState() public view returns (bool started, bool ended) {
        return (electionStarted, electionEnded);
    }
}