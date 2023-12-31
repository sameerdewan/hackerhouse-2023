// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Need to figure out how to trigger and bring on chain data from external source for riskRating (mock api)

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";

contract CarbonLink is ERC721, Ownable, FunctionsClient {
    using FunctionsRequest for FunctionsRequest.Request;

    uint64 subscriptionId;
    uint32 gasLimit;
    bytes32 jobId;
    uint256 public issuedCredits = 0;
    mapping(bytes32 => uint256) public requestIdToTokenId;

    struct Credit {
        string uuid;
        uint256 metricTonsCO2;
        uint256 price;
        bool retired;
        bool exists;
        uint256 riskRating;
        uint256 lastEvaluatedRiskDate;
        bytes32 latestRequestId;
    }

    mapping(uint256 => Credit) private credits;

    event OCRResponse(bytes32 indexed requestId, bytes result, bytes err);

    error UnknownRequestId(bytes32 requestId, bytes response, bytes err);

    modifier tokenExists(uint256 tokenId) {
        require(_exists(tokenId), "Token does not exist");
        _;
    }

    constructor(address oracle) FunctionsClient(oracle) ERC721("CarbonLink", "CLINK") {

    }

    function mintCarbonLink(
        string calldata uuid,
        uint256 metricTonsCO2,
        uint256 price,
        bool retired,
        uint256 riskRating,
        uint256 lastEvaluatedRiskDate,
        bytes32 latestRequestId
    ) public onlyOwner {
        uint256 tokenId = issuedCredits + 1;
        _mint(msg.sender, tokenId);
        credits[tokenId] = Credit({
            uuid: uuid,
            metricTonsCO2: metricTonsCO2,
            price: price,
            retired: retired,
            exists: true,
            riskRating: riskRating,
            lastEvaluatedRiskDate: lastEvaluatedRiskDate,
            latestRequestId: latestRequestId
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

  function requestRiskData(string calldata source, bytes calldata secrets, uint256 tokenId) public returns (bytes32) {
    FunctionsRequest.Request memory req;
    req.initializeRequest(FunctionsRequest.Location.Inline, FunctionsRequest.CodeLanguage.JavaScript, source);
    if (secrets.length > 0) req.addSecretsReference(secrets);
    
    bytes32 requestId = _sendRequest(
        req.encodeCBOR(), 
        subscriptionId, 
        gasLimit,
        jobId
    );
    requestIdToTokenId[requestId] = tokenId;
    return requestId;
  }

  function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override {
    uint256 riskRating = abi.decode(response, (uint256));
    uint256 tokenId = requestIdToTokenId[requestId];
    credits[tokenId].riskRating = riskRating;
    credits[tokenId].lastEvaluatedRiskDate = block.timestamp;
    emit OCRResponse(requestId, response, err);
  }  

  function setSubscriptionId(uint64 _subscriptionId) public onlyOwner {
    subscriptionId = _subscriptionId;
  }

  function setGasLimit(uint32 _gasLimit) public onlyOwner {
    gasLimit = _gasLimit;
  }

  function setJobId(bytes32 _jobId) public onlyOwner {
    jobId = _jobId;
  }
}
