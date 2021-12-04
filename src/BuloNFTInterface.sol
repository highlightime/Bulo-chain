pragma solidity ^0.8.0;

contract BuloNFTStorage {
    address public owner;

    uint public tokenId;

    struct GraveInfo {
        string name;
        string birth;
        string message;
        string imgUrl;
        uint tokenId;
    }

    mapping(address => GraveInfo) public graveInfoOf;
}

contract BuloNFTInterface is BuloNFTStorage {
    function registerGrave(
        string calldata name,
        string calldata birth,
        string calldata visitLog,
        string calldata imgUrl
    ) external returns (GraveInfo);
}
