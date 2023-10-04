// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BoredPetsNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  address marketplaceContract; // Address of the marketplace contract
  event NFTMinted(uint256); // emitted every time a NFT is minted

  constructor(address _marketplaceContract) ERC721("Bored Pets Yacht Club", "BPYC") {
    marketplaceContract = _marketplaceContract;
  }

  function mint(string memory _tokenURI) public  // tokem URI points to the JSON metadata on IPFS that stores the NFT's metadata
  {
    _tokenIds.increment();
    uint256 newTokenId = _tokenIds.current();
    _safeMint(msg.sender, newTokenId);
    _setTokenURI(newTokenId, _tokenURI);
    setApprovalForAll(marketplaceContract, true);
    emit NFTMinted(newTokenId);
  }
}
