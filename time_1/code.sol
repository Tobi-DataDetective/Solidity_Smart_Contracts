pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

contract myGame{
    uint public playercount = 0;
    mapping(address => Player) public PlayerID;

    enum Level {Novice, Intermediate, Advanced}

    struct Player {
        address playeraddress;
        Level playerLevel;
        string firstname;
        string lastname;
        uint createdTime;
    }
    function addplayer(string memory _firstname, string memory _lastname) public {
        // Player(_firstname, _lastname);
        PlayerID[msg.sender] = Player(msg.sender, Level.Novice,_firstname, _lastname, block.timestamp);
        playercount += 1;
    }
    function getPlayerLevel(address playeraddress) public view returns(Level){
        Player storage player = PlayerID[playeraddress];
        return player.playerLevel;
    }
    function changePlayerLevel(address playeraddress) public {
        Player storage player = PlayerID[playeraddress];
        if (block.timestamp >= player.createdTime + 20) {
            player.playerLevel = Level.Intermediate;
        }
    }
} 