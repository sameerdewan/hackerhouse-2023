// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";

contract RiskLedger is
    FunctionsClient,
    AutomationCompatibleInterface,
    ConfirmedOwner
{
  uint256 subscriptionId;
  uint256 gasLimit;

  struct Risk {
    uint256 rating;
    uint256 lastEvaluatedDate;
    bytes32 latestRequestId;
    bool exists;
  }

  mapping(uint256 => Risk) riskLedger;
  mapping(bytes32 => uint256) requestMap;

  event OCRResponse(bytes32 indexed requestId, bytes result, bytes err);

  error UnknownRequestId(bytes32 requestId, bytes response, bytes err);

  modifier requestExists(bytes32 requestId) {
    require(riskLedger[requestMap[requestId]].exists == true, "Unknown request id");
    _;
  }

  constructor(address oracle, uint256 _subscriptionId) FunctionsClient(oracle) ConfirmedOwner(msg.sender) {
    subscriptionId = _subscriptionId;
  }

  function requestRiskData(string calldata source, bytes calldata secrets, uint256 tokenId) public returns (bytes32) {
    Functions.Request memory req;
    req.initializeRequest(Functions.Location.Inline, Functions.CodeLanguage.JavaScript, source);
    if (secrets.length > 0) req.addRemoteSecrets(secrets);
    if (args.length > 0) req.addArgs(args);
    if (riskLedger[tokenId].exists == false) {
        riskLedger[tokenId] = Risk({
          rating: 0,
          lastEvaluatedDate: 0,
          latestRequestId: 0,
          exists: true
        });
    }
    riskLedger[tokenId].latestRequestId = sendRequest(req, subscriptionId, gasLimit);
    return riskLedger[tokenId].latestRequestId;
  }

  function fulfillRequest(bytes32 requestId, bytes memory response, bytes memory err) internal override requestExists(requestId) {
    // latestResponse = response;
    // latestError = err;
    
    emit OCRResponse(requestId, response, err);
  }  

  function setSubscriptionId(uint256 subscriptionId) onlyOwner {
    this.subscriptionId = subscriptionId;
  }

  function setGasLimit(uint256 gasLimit) onlyOwner {
    this.gasLimit = gasLimit;
  }
}
