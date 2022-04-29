# Solidity_Smart_Contracts
Building Smart Contracts using solidity with Practical Implementation

Some of the smart comtracts which can be found in the various folders are:

### Storage Smart Contract

A simple smart contract to take in values and store the value on record.

[storage contract here](https://github.com/Tobi-DataDetective/Solidity_Smart_Contracts/tree/main/Storage_Smart_Contact)

### Coin Minting Smart COntract
* A smart contract to create new coins.
* Coins can be minted only if the requirements are met.
* A requirement is that, only the creator or deployer of the contract can mint coins
* Ther minter can only mint coin or amount less than 1e60.
* Contract also allows the address which gets the amount from the minter to also tranfer amount to another address.
* Only the minter can mint and send to the sender
* Sender can only send to another address, based of some requirements
* A requirement is for the sender to have amount less than or equal to the amount intending to be sent.
* Amount is deducted from the sender after sending
* Amount is added to the recievers account i.e address.

[coin minting smart contract here](https://github.com/Tobi-DataDetective/Solidity_Smart_Contracts/tree/main/coin_minting)
