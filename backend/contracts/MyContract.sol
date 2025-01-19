// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyContract is ERC721, AccessControl {
    // Define MINTER_ROLE for minting permissions
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // Declare a simple counter to track token IDs
    uint256 private _tokenIdCounter;

    constructor() ERC721("MyContract", "MYC") {
        // Grant the default admin role and minter role to the contract deployer
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    // Function to safely mint a new token
    function safeMint(address to) public onlyRole(MINTER_ROLE) {
        // Use the manual counter to assign a token ID
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter += 1; // Increment the counter
        _safeMint(to, tokenId);
    }

    // Override supportsInterface to integrate AccessControl
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
