pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract myGame {
    uint public playercount = 0;
    uint public pot = 0;

    address public dealer;
    Player[] public playersInGame;

    mapping(address => Player) public players;

    enum Level {Novice, Intermediate, Advanced}

    struct Player {
        address playeraddress;
        Level playerLevel;
        string firstname;
        string lastname;
        uint createdTime;
    }

    constructor(){
        dealer = msg.sender;
    }
    function addplayer(string memory _firstname, string memory _lastname) private {
        Player memory newPlayer = Player(msg.sender, Level.Novice, _firstname, _lastname, block.timestamp);
        players[msg.sender] = newPlayer;
        playersInGame.push(newPlayer);
    }
    function getPlayerLevel(address playeraddress) private{
        Player storage player = players[playeraddress];
    }
    function changePlayerLevel(address playeraddress) private {
        Player storage player = players[playeraddress];
        if (block.timestamp >= player.createdTime + 20) {
            player.playerLevel = Level.Intermediate;
        }
    }

    function joinGame(string memory _firstname, string memory _lastname) payable public {
        require(msg.value == 25 ether, "the joining is 25 ether");
        if (payable(dealer).send(msg.value)){
            addplayer(_firstname, _lastname);
            playercount += 1;
            pot += 25;
        }
    }
    function payOutWinners(address loserAddress) payable public{
        require(msg.sender == dealer, "only dealer can pay the winners");
        require(msg.value == pot * (1 ether));
        uint payoutPerWinner = msg.value / (playercount - 1);
        for (uint i; i<playersInGame.length; i++){
            address currentPlayerAddress = playersInGame[i].playeraddress;
            if (currentPlayerAddress != loserAddress){
                payable(currentPlayerAddress).transfer(payoutPerWinner);
            }
        }
    }
} 