
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