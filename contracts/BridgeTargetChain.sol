// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./BLimeToken.sol";

contract BridgeTargetChain  {

    BLimeToken private BToken;
    bool BridgeInitialized;
    address owner;
    address gateway;
    

    constructor(address _gateway) {
        owner = msg.sender;
        gateway = _gateway;
    }

    event Minted(uint256 value);
    event Burned(uint256 value);

    function init (address _bridge) public {
        BToken = BLimeToken(_bridge);
        BridgeInitialized = true;
    }

    function mint(address _to, uint256 _amount) public VerifyInitialization onlyGateway  {
        require(_amount > 0);
        BToken.mint(_to, _amount);
        emit Minted(_amount);
    }
    
    function burn (uint256 _amount) public VerifyInitialization onlyGateway   {
        BToken.burn(_amount);
        emit Burned(_amount);
    }

    modifier VerifyInitialization() {
        require(BridgeInitialized, "Bridge is not initialized");
        _;
    }

    modifier onlyGateway() {
        require(msg.sender == gateway, "Only gateway can call this function");
        _;
    }

}
