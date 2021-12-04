// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./VaultInterface.sol";

contract Vault is VaultInterface {
    event NewDonatation(address vaultOwner, address contributor, uint amount);
    event NewVault(uint tokenId, address vaultOwner, address donateTarget);
    event NewDonateTarget(address vaultOwner, address oldDonateTarget, address newDonateTarget);
    event Transfer(address src, address to, uint amount);

    constructor(BuloNFTInterface buloNft_) {
        admin = msg.sender;
        buloNft = buloNft_;
    }

    receive () external payable {
        // free donate..?
    }

    function createVault(uint tokenId_, address vaultOwner_, address donateTarget_) external override returns (VaultInfo memory) {
        require(msg.sender == vaultOwner_);
        require(buloNft.getMyTokenId(msg.sender) == tokenId_);
        require(!vaultInfoOf[vaultOwner_].isActive);

        vaultInfoOf[vaultOwner_].isActive = true;
        vaultInfoOf[vaultOwner_].tokenId = tokenId_;
        vaultInfoOf[vaultOwner_].donateTarget = donateTarget_;

        emit NewVault(
            vaultInfoOf[vaultOwner_].tokenId,
            vaultOwner_,
            vaultInfoOf[vaultOwner_].donateTarget
        );

        return vaultInfoOf[vaultOwner_];
    }

    function updateDonateTarget(address vaultOwner_, address donateTarget_) external override returns (VaultInfo memory) {
        require(msg.sender == vaultOwner_);

        address oldDonateTarget = vaultInfoOf[vaultOwner_].donateTarget;

        vaultInfoOf[vaultOwner_].donateTarget = donateTarget_;

        emit NewDonateTarget(vaultOwner_, oldDonateTarget, vaultInfoOf[vaultOwner_].donateTarget);

        return vaultInfoOf[vaultOwner_];
    }

    // add ETH to vault
    function donateTo(address vaultOwner_, uint amount) external override returns (VaultInfo memory) {
        require(vaultInfoOf[vaultOwner_].isActive);

        uint actualDonateAmount = transferIn(msg.sender, amount);

        vaultInfoOf[vaultOwner_].balanceOf += actualDonateAmount;
        vaultInfoOf[vaultOwner_].contributors.push(msg.sender);
        totalAmount += actualDonateAmount;

        emit NewDonatation(vaultOwner_, msg.sender, amount);

        return vaultInfoOf[vaultOwner_];
    }

    // TRIGGER for donation execution to donateTarget
    function executeDonation(address vaultOwner_) external override returns (uint) {
        require(vaultInfoOf[vaultOwner_].balanceOf > 0);

        uint balanceBeforeTransfer = vaultInfoOf[vaultOwner_].balanceOf;

        transferOut(payable(vaultInfoOf[vaultOwner_].donateTarget), vaultInfoOf[vaultOwner_].balanceOf);
        vaultInfoOf[vaultOwner_].balanceOf = 0;

        emit Transfer(
            vaultOwner_,
            vaultInfoOf[vaultOwner_].donateTarget,
            balanceBeforeTransfer
        );

        return balanceBeforeTransfer;
    }

    function transferIn(address from, uint amount) internal returns (uint) {
        require(msg.sender == from, "sender mismatch");
        require(msg.value == amount, "value mismatch");
        return amount;
    }

    function transferOut(address payable to, uint amount) internal {
        to.transfer(amount);
    }
}
