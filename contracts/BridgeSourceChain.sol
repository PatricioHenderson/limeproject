// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;

contract  BridgeSourceChain  {

    constructor(address sourceToken, address gateway) {
        _sourceToken = sourceToken;
        _gateway = gateway;
    }

    event LockedTokens(uint256 value);
    event ReleasedTokens(uint256 value);

    function lock (address sender, uint value) public onlyGateway {
        require(value > 0);
        emit LockedTokens(value);
    }

    function release (address requester, uint value) public onlyGateway {
        require(value > 0);
        sourceToken.transfer(requester, value);
        emit ReleasedTokens(value);
    }


    modifier onlyGateway {
        require(msg.sender == _gateway, "Only gateway can call this function");
        _();
    }


}
