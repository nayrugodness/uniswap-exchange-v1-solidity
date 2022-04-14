//title Uniswap Exchange Interface V1
//notice Source code found at https://github.com/uniswap
//notice Use at your own risk
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract factory {
        
    function getExchange(address tokenAddr) public pure returns (address) {
        return address(tokenAddr);
    }
}
contract exchange {
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
