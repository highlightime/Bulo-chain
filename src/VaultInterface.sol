// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BuloNFTInterface.sol";

abstract contract VaultStorage {

    BuloNFTInterface public buloNft;

    uint public donationBlockGap;

    address public admin;

    struct VaultInfo {
        bool isActive;
        uint balanceOf;
        uint tokenId;
        uint lastDonationBlockNumber;
        address donateTarget;
        address[] contributors;
    }
    
    // vault owner => VaultInfo
    mapping(address => VaultInfo) public vaultInfoOf;

    uint public totalAmount;
}

abstract contract VaultInterface is VaultStorage {
    function createVault(uint tokenId_, address vaultOwner_, address donateTarget_) external virtual returns (VaultInfo memory);

    function updateDonateTarget(address vaultOwner_, address donateTarget_) external virtual returns (VaultInfo memory);

    function donateTo(address vaultOwner_, uint amount) external virtual returns (VaultInfo memory);

    function executeDonation(address vaultOwner_) external virtual returns (uint);
}
