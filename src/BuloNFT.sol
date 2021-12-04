// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./BuloNFTInterface.sol";

contract BuloNFT is ERC1155, BuloNFTStorage{
    event NewGrave(string _name, string _birth, uint _tokenId);

    constructor(string memory initURI) ERC1155(initURI) {
        _setURI(initURI);
    }

    modifier onlyOwnerOf(uint _graveId) {
        require(msg.sender == graveToOwner[_graveId]);
        _;
    }

    function registerGrave(string calldata _name, string calldata _birth, string calldata _uri, uint256 _tokenId) external virtual {
        GraveInfo memory myGrave=GraveInfo(_name, _birth, _tokenId);
        Graves.push(myGrave);
        graveToOwner[_tokenId] = msg.sender;
        graveInfoOf[msg.sender]= myGrave;
        mintGrave(msg.sender, _uri,_tokenId);

        emit NewGrave(_name, _birth, _tokenId);
    }

    function mintGrave(address owner, string memory metadataURI, uint _tokenId) internal returns (uint256){
        _mint(owner, _tokenId, 1, "");
        _setURI(metadataURI);

        return _tokenId;
    }
}

