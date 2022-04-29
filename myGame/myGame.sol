pragma solidity >=0.7.0 < 0.9.0;

// SPDX-License-Identifier:MIT

// contract myContract {
//     uint public constant myconstant = 1;
//     uint public myint = 1;
//     int public myint = -1;
//     string public mystring = "mystring";
//     bool public mybool = true;
// }

// contract myGame{
//     uint public playercount = 0;
//     Player[] public playerID;
//     struct Player {
//         string firstname;
//         string lastname;
//     }
//     function addplayer(string memory _firstname, string memory _lastname) public {
//         // Player(_firstname, _lastname);
//         playerID.push(Player(_firstname, _lastname));
//         playercount += 1;

//     }
// }



// contract myGame{
//     uint public playercount = 0;
//     mapping(address => Player) public PlayerID;

//     struct Player {
//         address playeraddress;
//         string firstname;
//         string lastname;
//     }
//     function addplayer(string memory _firstname, string memory _lastname) public {
//         // Player(_firstname, _lastname);
//         PlayerID[msg.sender] = Player(msg.sender, _firstname, _lastname);
//         playercount += 1;

//     }
// }


contract myGame{
    uint public playercount = 0;
    mapping(address => Player) public PlayerID;

    enum Level {Novice, Intermediate, Advanced}

    struct Player {
        address playeraddress;
        Level playerLevel;
        string firstname;
        string lastname;
    }
    function addplayer(string memory _firstname, string memory _lastname) public {
        // Player(_firstname, _lastname);
        PlayerID[msg.sender] = Player(msg.sender, Level.Novice,_firstname, _lastname);
        playercount += 1;
    }
    function getPlayerLevel(address playeraddress) public view returns(Level){
        return PlayerID[playeraddress].playerLevel;
    }
}