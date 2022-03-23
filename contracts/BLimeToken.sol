// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;
pragma abicoder v2;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";

contract BLimeToken is  ERC20PresetMinterPauser {

    bool BLimeTokenDeployed;
    address private owner;

    constructor () ERC20PresetMinterPauser("BLimeToken", "BLMT") {
        require(BLimeTokenDeployed == false);
        BLimeTokenDeployed = true;
        owner = msg.sender;       
      }


    function mint(address _to, uint256 _amount) public onlyOwner override {
        mint(_to, _amount);
    }


    modifier onlyOwner(){
    require(msg.sender == owner);
    _;
}

}

