# Carbon Link (CLINK)

We are on a mission to provide a bridge to tokenize carbon credits and to allow blockchain interoperability. 

-> Owners can mint carbon credits
-> Users can buy carbon credits and transfer 


# CarbonLink.sol

CarbonLink.sol is a Solidity contract that implements a system for tokenizing carbon credits. It inherits from the OpenZeppelin ERC721 and Ownable contracts, which provide functionality for non-fungible tokens and basic authorization control, respectively.
Data Structures
Credit

The Credit struct represents a carbon credit. It has the following fields:

- description: A string that describes the carbon credit.
- uri: A string that points to the metadata of the carbon credit.
- valid: A boolean that indicates whether the carbon credit is valid.
State Variables

- totalCarbonCredits: The total number of carbon credits that have been minted.
- carbonCreditPrice: The price of a carbon credit in wei.
- carbonOffsets: A mapping from token IDs to Credit structs.
Modifiers

- tokenExists: Checks if a token with the given ID exists.
- hasSufficientFunds: Checks if the message sender has sent enough ether to buy a carbon credit.
Functions

`mintCarbonLink`
```
This function allows the owner of the contract to mint a new carbon credit. It takes a URI and a description as arguments, both of which are used to create a new Credit struct. The new credit is then added to the carbonOffsets mapping and the totalCarbonCredits counter is incremented.
```

`setCarbonPrice`
```
This function allows the owner of the contract to set the price of carbon credits. It takes the new price as an argument.
```

`retireCarbonLink`
```
This function allows the owner of the contract to retire a carbon credit, making it invalid. It takes the ID of the token to retire as an argument.
```

`buyCarbonLink`
```
This function allows anyone to buy a carbon credit. It checks if the sender has sent enough ether and if there are any credits available. If both conditions are met, it transfers a credit to the sender and decrements the totalCarbonCredits counter.
```
`getCarbonLink`
```
This function allows anyone to view the details of a carbon credit. It takes the ID of the token to view as an argument and returns the corresponding Credit struct.
```
`Constructor`

```
The constructor sets the name and symbol of the token to "CarbonLink" and "CLINK", respectively.
```

# Hardhat Setup

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```
