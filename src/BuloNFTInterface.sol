// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuloNFTStorage {
    struct GraveInfo {
        string name;
        string birth;
        uint256 tokenId; 
    }

    GraveInfo[] public Graves;
    
    mapping (uint => address) public graveToOwner;
    mapping(address => GraveInfo) public graveInfoOf;
}

abstract contract BuloNFTInterface is BuloNFTStorage {
    function registerGrave(string calldata name,string calldata birth, string calldata _uri,uint _tokenId) external virtual;

    function getMyTokenId(address owner)public view virtual returns(uint256);
}
