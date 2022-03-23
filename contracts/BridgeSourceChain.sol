// SPDX-License-Identifier: Unlicensed

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "./BLimeToken.sol";

pragma solidity ^0.7.0;

contract  BridgeSourceChain  {

    IERC20 public _sourceToken;
    BLimeToken public _targetToken;
    // address owner = msg.sender;
    mapping (address => uint256) public _balanceOf;

    constructor(address _sourceToken, address _gateway) {
        _sourceToken = _sourceToken;
        _targetToken = _targetToken;
    }

    event LockedTokens(uint256 amount, address _to);
    event ReleasedTokens(uint256 amount, address _to);

    function lock () public payable {
        require(msg.value > 0, "We need some Tokens to lock");
        _balanceOf[msg.sender] += msg.value;
        _targetToken.mint(msg.sender, msg.value);
        _sourceToken.transfer(msg.sender, msg.value);
        emit LockedTokens(msg.value, msg.sender);
    }

    function release (uint value) public {
        require(value > 0, "We need some Tokens to release");
        require(_balanceOf[msg.sender] >= value, "You don't have enough Tokens to release");
        _balanceOf[msg.sender] -= value;
        _sourceToken.transfer(msg.sender, value);
        _targetToken.burn(value);
        emit ReleasedTokens(value, msg.sender);

    }
    




}
