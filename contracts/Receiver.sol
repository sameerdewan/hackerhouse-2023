// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import "./CarbonLink.sol";


contract Receiver is CCIPReceiver {
    CarbonLink cLink;

    event MessageReceived(
        bytes32 indexed messageId,
        uint64 indexed sourceChainSelector,
        address sender,
        string text
    );

    bytes32 private lastReceivedMessageId;
    string private lastReceivedText;

    constructor(address router, address nftAddr) CCIPReceiver(router) {
        cLink = CarbonLink(nftAddr);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory any2EvmMessage
    ) internal override {
        (bool success, ) = address(cLink).call(any2EvmMessage.data);
        require(success);
    }

    function getLastReceivedMessageDetails()
        external
        view
        returns (bytes32 messageId, string memory text)
    {
        return (lastReceivedMessageId, lastReceivedText);
    }
}
