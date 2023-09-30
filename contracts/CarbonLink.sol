// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CarbonLink is ERC721, Ownable {
    uint256 public issuedCredits = 0;

    struct Credit {
        string uuid;
        string issuer;
        uint256 metricTonsCO2;
        uint256 issueDate;
        uint256 expiryDate;
        string greenHouseGasType;
        string standard;
        string region;
        string projectType;
        uint256 price;
        bool retired;
        string description;
        bool exists;
        uint256 riskRating;
        uint256 lastEvaluatedRiskDate;
    }

    mapping(uint256 => Credit) private credits;

    modifier tokenExists(uint256 tokenId) {
        require(_exists(tokenId), "Token does not exist");
        _;
    }

    constructor() ERC721("CarbonLink", "CLINK") {}

    function mintCarbonLink(
        string calldata uuid,
        string calldata issuer,
        uint256 metricTonsCO2,
        uint256 issueDate,
        uint256 expiryDate,
        string calldata greenHouseGasType,
        string calldata standard,
        string calldata region,
        string calldata projectType,
        uint256 price,
        bool retired,
        string calldata description,
        uint256 riskRating,
        uint256 lastEvaluatedRiskDate
    ) public onlyOwner {
        uint256 tokenId = issuedCredits + 1;
        _mint(msg.sender, tokenId);
        credits[tokenId] = Credit({
            uuid: uuid,
            issuer: issuer,
            metricTonsCO2: metricTonsCO2,
            issueDate: issueDate,
            expiryDate: expiryDate,
            greenHouseGasType: greenHouseGasType,
            standard: standard,
            region: region,
            projectType: projectType,
            price: price,
            retired: retired,
            description: description,
            exists: true,
            riskRating: riskRating,
            lastEvaluatedRiskDate: lastEvaluatedRiskDate
        });
    }

    function retireCarbonLink(
        uint256 tokenId
    ) public onlyOwner tokenExists(tokenId) {
        credits[tokenId].retired = true;
    }

    function buyCarbonLink(
        uint256 tokenId
    ) public payable tokenExists(tokenId) {
        require(msg.value >= credits[tokenId].price, "Insufficient funds");
        _transfer(address(this), msg.sender, 1);
    }

    function getCarbonLink(
        uint256 tokenId
    ) public view tokenExists(tokenId) returns (Credit memory) {
        return credits[tokenId];
    }
}
