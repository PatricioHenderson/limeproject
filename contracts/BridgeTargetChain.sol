// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.7.0;
pragma abicoder v2;


import "./BLimeToken.sol";

contract BridgeTargetChain  {

    BLimeToken private BToken;
    address private owner;
    bool BLimeTokenDeployed;
    
    

    constructor(address _gateway) {
        owner = msg.sender;
    }

    event Minted(uint256 value);
    event Burned(uint256 value);



    function mint(address _to, uint256 _amount) public onlyOwner  deployBLimeToken {
        require(_amount > 0);
        BToken.mint(_to, _amount);
        emit Minted(_amount);
    }
    
    function burn (uint256 _amount) public onlyOwner  {
        BToken.burn(_amount);
        emit Burned(_amount);
    }

    modifier deployBLimeToken {
        require(BLimeTokenDeployed == false);
        BLimeTokenDeployed = true;
        _;
    }

    

    // modifier deployBLimeToken() {
    //     require(BToken.BLimeTokenDeployed == false);
    //     BToken.BLimeTokenDeployed = true;
    //     _;

    //     // if (BToken.BLimeTokenDeployed == false) {
    //     //     BToken = BLimeToken("BLimeToken", "BLMT");
    //     //     BToken.BLimeTokenDeployed = true;
    //     //     owner = msg.sender;
    //     // }
    //     // _;
    // }

    modifier onlyOwner(){
    require(msg.sender == owner);
    _;
}

}
