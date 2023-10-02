// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeBtoA is Ownable {
	IERC20 public tokenA;
	IERC20 public tokenB;

	event TokensLocked(address sender, uint256 amount);
	event TokensReleased(address receiver, uint256 amount);

	constructor(address _tokenAAddress, address _tokenBAddress) {
		tokenA = IERC20(_tokenAAddress);
		tokenB = IERC20(_tokenBAddress);
	}

	function lockTokens(uint256 amount) external {
		require(amount > 0, "Amount must be greater than 0");
		require(tokenB.transferFrom(msg.sender, address(this), amount), "Transfer failed");
		emit TokensLocked(msg.sender, amount);
	}

	function releaseTokens(address receiver, uint256 amount) external onlyOwner {
		require(amount > 0, "Amount must be greater than 0");
		require(tokenA.transfer(receiver, amount), "Transfer failed");
		emit TokensReleased(receiver, amount);
	}
}
