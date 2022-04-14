//title Uniswap Exchange Interface V1
//notice Source code found at https://github.com/uniswap
//notice Use at your own risk
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Factory {
        
    function getExchange(address tokenAddr) public pure returns (address) {
        return address(tokenAddr);
    }
}
contract Exchange {
    function getEthToTokenOutputPrice(uint256 tokensBought) public pure returns (uint256) {
        return uint256(wei);
    }

    function ethToTokenTransferInput(uint256 minTokens, address recipient) public pure returns (uint256) {}

    function ethToTokenTransferOutput(uint256 tokensBought, address recipient) public pure returns (uint256) {
        return uint256(wei);
    }
}

event TokenPurchase(
    address indexed buyer,
    uint256(wei) indexed ethSold,
    uint256 indexed tokensBought
);

event EthPurchase(
    address indexed buyer,
    uint256 indexed tokensSold,
    uint256(wei) indexed ethBought
);

event AddLiquidity(
    address indexed provider,
    uint256(wei) indexed ethAmount,
    uint256 indexed tokenAmount
);

event RemoveLiquidity(
    address indexed provider,
    uint256(wei) indexed ethAmount,
    uint256 indexed tokenAmount
);

event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
);

event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
);


bytes32 public name;
bytes32 public symbol;
uint256 public decimals;
uint256 public totalSupply;
uint256[address] balances;
(uint256[address])[address] allowances;
address(erc20) token;
factory = Factory

function tokenToEthSwapInput(uint256 tokensSold, uint256(wei) minEth, timestamp deadline) public pure returns (uint256(wei)) {
    return tokenToEthInput(tokensSold, minEth, deadline, msg.sender, msg.sender);
}