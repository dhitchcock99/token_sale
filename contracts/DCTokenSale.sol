pragma solidity ^0.5.0;

import "./DCToken.sol";

contract DCTokenSale {
	address payable admin;
	DCToken public tokenContract;
	uint256 public tokenPrice;
	uint256 public tokensSold;

	event Sell(address _buyer, uint256 _amount);

	constructor(DCToken _tokenContract, uint256 _tokenPrice) public {
		// Assign an admin
		admin = msg.sender;

		// Token Contract		
		tokenContract = _tokenContract;

		// Token Price
		tokenPrice = _tokenPrice;
	}

	function multiply(uint x, uint y)
 		internal pure returns (uint z) {
 		require(y == 0 || (z = x * y) / y == x);
 	}

	// Buy Tokens
	function buyTokens(uint256 _numberOfTokens) public payable {

		// Require that value is equal to tokens
		require(msg.value == multiply(_numberOfTokens, tokenPrice));

		// Require that the contract has enough tokens
		require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);

		// Require that a transfer is successful
		require(tokenContract.transfer(msg.sender, _numberOfTokens));

		// Keep track of tokensSold
		tokensSold += _numberOfTokens;

		// Trigger Sell EVent
		emit Sell(msg.sender, _numberOfTokens);
	}

	// Ending the token sale
	function endSale() public {
		// Require admin
		require(msg.sender == admin);
		// Transfer remaining tokens to admin
		require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
		// Transfer the balance to admin
		admin.transfer(address(this).balance);
	}



}