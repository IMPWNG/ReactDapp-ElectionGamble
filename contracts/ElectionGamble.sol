//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.3;

contract ElectionGamble {
    enum Side { Macron, Lepen }
    struct Result {
        Side winner;
        Side loser;
    }
    Result public result;

    address public oracle;
    bool public electionFinished;

    mapping(Side => uint) public bets;
    mapping(address => mapping(Side => uint)) public betsPerGambler;

    constructor(address _oracle) {
        oracle = _oracle;
    }

    function placeBet(Side _side) external payable {
        require(electionFinished == false, 'election is finished');
        bets[_side] += msg.value;
        betsPerGambler[msg.sender][_side] += msg.value; 
    }

    function withdrawGain() external {
        uint gamblerBet = betsPerGambler[msg.sender][result.winner];
        require(gamblerBet > 0, 'you do not have any winning bet');
        require(electionFinished == true, 'election not finished');
        uint gain = gamblerBet + bets[result.loser] * gamblerBet / bets[result.winner];
        betsPerGambler[msg.sender][Side.Macron] = 0;
        betsPerGambler[msg.sender][Side.Lepen] = 0;
        msg.sender.transfer(gain);
    }

    function reportResult(Side _winner, Side _loser) external {
        require(oracle == msg.sender, 'only oracle');
        require(electionFinished == false, 'election is finished');
        result.winner = _winner;
        result.loser = _loser;
        electionFinished = true;
    }
}