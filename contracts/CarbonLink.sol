// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract CarbonLink is ERC721, Ownable {
    uint256 public totalCarbonCredits = 0;
    uint256 public carbonCreditPrice = 0.01 ether;

    struct Credit {
        string description;
        string uri;
        bool valid;
    }

    mapping(uint256 => Credit) private carbonOffsets;

    modifier tokenExists(uint256 tokenId) {
        require(_exists(tokenId), "Token does not exist");
        _;
    }

    modifier hasSufficientFunds() {
        require(msg.value >= carbonCreditPrice, "Insufficient funds");
        _;
    }

    constructor() ERC721("CarbonLink", "CLINK") {}

    function mintCarbonLink(
        string calldata uri,
        string calldata description
    ) public onlyOwner {
        uint256 tokenId = totalCarbonCredits + 1;
        _mint(msg.sender, tokenId);
        carbonOffsets[tokenId] = Credit({
            description: description,
            uri: uri,
            valid: true
        });
        totalCarbonCredits++;
    }

    function setCarbonPrice(uint256 newPrice) public onlyOwner {
        carbonCreditPrice = newPrice;
    }

    function retireCarbonLink(
        uint256 tokenId
    ) public onlyOwner tokenExists(tokenId) {
        carbonOffsets[tokenId].valid = false;
    }

    function buyCarbonLink() public payable hasSufficientFunds {
        require(totalCarbonCredits > 0, "No carbon credits in stock");
        _transfer(address(this), msg.sender, 1);
        totalCarbonCredits--;
    }

    function getCarbonLink(
        uint256 tokenId
    )
        public
        view
        tokenExists(tokenId)
        returns (Credit memory)
    {
        return carbonOffsets[tokenId];
    }
}
