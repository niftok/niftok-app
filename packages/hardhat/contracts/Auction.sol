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
    mapping (string => bool) internal minted;

    Niftok nft;

    constructor(address nft_addr) public {
        Niftok nft = Niftok(nft_addr);
    }

    function endAuction(string memory tokenURI) public {
        require(!minted[tokenURI], "Already minted");
        require(auctionEnd[tokenURI] <= block.timestamp, "Auction has not ended yet");
        minted[tokenURI] == true;
        nft.mintNft(maxBid[tokenURI].bidder, tokenURI);

        emit AuctionEnd(tokenURI, maxBid[tokenURI].bidder, maxBid[tokenURI].bidPrice);
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

        emit BidMade(tokenURI, msg.sender, bidPrice);
    }

    function auctionEndTime(string memory tokenURI) public view returns (uint) {
        return auctionEnd[tokenURI];
    }

    function currentBid(string memory tokenURI) public view returns (address, uint256) {
        return (maxBid[tokenURI].bidder, maxBid[tokenURI].bidPrice);
    }

    function isMinted(string memory tokenURI) public view returns (bool) {
        return minted[tokenURI];
    }

    event BidMade(string indexed _tokenURI, address indexed _bidder, uint256 _bidPrice);
    event AuctionEnd(string indexed _tokenURI, address indexed _winner, uint256 _winPrice);
}
