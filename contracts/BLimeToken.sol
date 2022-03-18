// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BLimeToken is ERC20, ERC20Burnable, Ownable {

    address  _bridgeAddress;

    constructor (address _bridge) ERC20("BLimeToken", "BLMT") {
        _bridge = _bridge;
    }

    function mint(address _to, uint256 _amount) public onlyBridge virtual {
        require(_amount > 0);
        mint(_to, _amount);
    }

    function burn(uint256 _amount) public onlyBridge override virtual{
        burn(_amount);
    }

    modifier onlyBridge() {
        require(msg.sender == _bridgeAddress, "Only bridge can call this function");
        _;
    }
}

