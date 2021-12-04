// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuloNFTStorage {
    struct GraveInfo {
        string uri;
        uint tokenId;
    }

    GraveInfo[] public Graves;
    
    mapping (uint => address) public graveToOwner;
    mapping(address => GraveInfo) public graveInfoOf;
}

abstract contract BuloNFTInterface is BuloNFTStorage {
    function registerGrave(string calldata _uri) external virtual returns (uint256);

    function getMyTokenId(address owner)public view virtual returns(uint256);
}
