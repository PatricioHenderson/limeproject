// SPDX-License-Identifier: Unlicensed

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.7.0;

contract  BridgeSourceChain  {

    IERC20 private _sourceToken;

    address _gateway;

    constructor(address _sourceToken, address _gateway) {
        _sourceToken = _sourceToken;
        _gateway = _gateway;
    }

    event LockedTokens(uint256 value);
    event ReleasedTokens(uint256 value);

    function lock (address sender, uint value) public onlyGateway {
        require(value > 0);
        emit LockedTokens(value);
    }

    function release (address requester, uint value) public onlyGateway {
        require(value > 0);
        _sourceToken.transfer(requester, value);
        emit ReleasedTokens(value);
    }


    modifier onlyGateway {
        require(msg.sender == _gateway, "Only gateway can call this function");
        _;
    }


}
