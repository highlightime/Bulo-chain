// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./BuloNFTInterface.sol";

contract BuloNFT is ERC1155, BuloNFTStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event NewGrave(string _uri, uint256 _tokenId);

    constructor(string memory initURI) ERC1155(initURI) {
        _setURI(initURI);
    }

    modifier onlyOwnerOf(uint _graveId) {
        require(msg.sender == graveToOwner[_graveId]);
        _;
    }

    function registerGrave(string calldata _uri) external virtual returns (uint256){
        _tokenIds.increment();
        uint256 id = _tokenIds.current();
        GraveInfo memory myGrave=GraveInfo(_uri, id);
        Graves.push(myGrave);
        graveToOwner[id] = msg.sender;
        graveInfoOf[msg.sender]= myGrave;
        mintGrave(msg.sender, _uri, id);

        emit NewGrave(_uri, id);

        return id;
    }

    function mintGrave(address owner, string memory metadataURI, uint id) internal {
        _mint(owner, id, 1, "");
        _setURI(metadataURI);
    }

    function getMyTokenId(address owner)public view returns(uint256){
        return graveInfoOf[owner].tokenId;
    }
}