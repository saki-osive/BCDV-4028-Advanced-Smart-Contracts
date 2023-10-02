// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenB is ERC20 {
	constructor() ERC20("TokenB", "TOKB") {
		_mint(msg.sender, 1000000 * 10 ** uint256(decimals()));
	}
}
