// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./BlimeToken.sol"

contract BridgeTargetChain is BLimeToken {

    bool BridgeInitialized;
    address owner;
    address gateway;

    constructor(address _gateway) {
        owner = msg.sender;
        gateway = _gateway;
    }

    event Minted(uint256 value);
    event Burned(uint256 value);


    function init(address _BTokenAddress) onlyOwner external {
        BToken = _bridgeAddress;
        BridgeInitialized = true;
    }

    function mint(address _to, uint256 _amount) verifyInitialization onlyGateway {
        require(_amount > 0);
        BLimeToken.mint(_to, _amount);
        emit Minted(_amount);
    }
    
    function burn (uint256 _amount) verifyInitialization onlyGateway {
        _burn(_amount);
        BLimeToken.burn(_amount);
        emit Burned(_amount);
    }

    modifier VerifyInitialization() {
        require(BridgeInitialized, "Bridge is not initialized");
        _;
    }

    modifier onlyGateway() {
        require(msg.sender == _gateway, "Only gateway can call this function");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

}
