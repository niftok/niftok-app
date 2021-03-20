pragma solidity ^0.6.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Niftok.sol";


contract Auction {

    using SafeMath for uint256;

    struct Bid {
        address payable bidder;
        uint256 bidPrice;
    }

    mapping (string => uint256) internal uriToId;
    mapping (string => Bid) internal maxBid;
    mapping (string => uint) internal auctionEnd;

    Niftok nft;

    constructor(address nft_addr) public {
        Niftok nft = Niftok(nft_addr);
    }

    function endAuction(string memory tokenURI) public {
        require(auctionEnd[tokenURI] <= block.timestamp, "Auction has not ended yet");
        nft.mintNft(maxBid[tokenURI].bidder, tokenURI);
    }

    function bid(string memory tokenURI, uint256 bidPrice) public payable {
        if (maxBid[tokenURI].bidPrice == 0) { // No one has bid before
            require(bidPrice > 1 finney, "Below minimum bid");
            auctionEnd[tokenURI] = block.timestamp + 1 weeks;
        } else {
            require(block.timestamp < auctionEnd[tokenURI], "Auction has ended");
            require(bidPrice > maxBid[tokenURI].bidPrice.mul(11).div(10), "Require 10% bid increase");

            // Return Ether back to previous high bidder
            maxBid[tokenURI].bidder.transfer(maxBid[tokenURI].bidPrice);

            Bid memory newBid = Bid(msg.sender, bidPrice);
            maxBid[tokenURI] = newBid;
            msg.sender.transfer(bidPrice);
        }
    }

    function auctionEndTime(string memory tokenURI) public view returns (uint) {
        return auctionEnd[tokenURI];
    }

    function currentBid(string memory tokenURI) public view returns (address, uint256) {
        return (maxBid[tokenURI].bidder, maxBid[tokenURI].bidPrice);
    }
}
