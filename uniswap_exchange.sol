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

function setup(address tokenAddr) public pure {
    assert(this.factory == address(0) && this.token == address(0) and tokenAddr != address(0));
    this.factory = msg.sender;
    this.token = tokenAddr;
    this.name = 0x556e697377617020563100000000000000000000000000000000000000000000
    this.symbol = 0x554e492d56310000000000000000000000000000000000000000000000000000
    this.decimals = 18;
}

function addLiquidity(uint256 minLiquidity, uint256 maxTokens, timestamp deadline) public payable returns(uint256) {
    assert(deadline > block.timestamp && (maxTokens > 0 && msg.value > 0));
    uint256 totalLiquidity = this.totalSupply
    if (totalLiquidity > 0) {
        assert(minLiquidity > 0);
        uint256(wei) ethReserve = this.balance - msg.value;
        uint256 tokenReserve = this.token.balances(this)
        uint256 tokenAmount = msg.value * tokenReserve / ethReserve + 1
        uint256 liquidityMinted = msg.value * totalLiquidity / ethReserve
        
        assert(maxTokens >= tokenAmount && liquidityMinted >= minLiquidity);
        this.balances[msg.sender] += liquidityMinted
        this.totalSupply = totalLiquidity + liquidityMinted

        assert(this.token.transferFrom(msg.sender, this, tokenAmount));

        addLiquidity(msg.sender, msg.value, tokenAmount).log()
        transfer(address(0), msg.sender, liquidityMinted)

        return uint256(liquidityMinted);

    } else {
        assert(this.factory != address(0) && this.token != address(0) && msg.value >= 1000000000 );

        assert( this.factory.getExchange(this.token) == this);
        uint256 tokenAmount = maxTokens
        uint256 initialLiquidity = asUnitlessNumber(this.balance)
        this.totalSupply = initialLiquidity
        this.balance[msg.sender] = initialLiquidity
        
        assert(this.token.transferFrom(msg.sender, this, tokenAmount));
        addLiquidity(msg.sender, msg.value, tokenAmount).log()
        transfer(address(0), msg.sender, liquidityMinted)

        return unit256(liquidityMinted)
    }
}

function removeLiquidity(uint256 amount, uint256(wei) minEth, uint256 minTokens, timestamp deadline) public returns(){
    assert(amount > 0 && deadline > block.timestamp && minEth > 0 && minTokens > 0);
    uint256 totalLiquidity = this.totalSupply
    assert(totalLiquidity > 0);
    uint256 tokenReserve = this.tokenBalanceOf(this)
    uint256(wei) ethAmount = amount *this.balance / totalSupply
    
    assert(ethAmount >= minEth && tokenAmount >= minTokens);
    this.balances[msg.sender] -= amount
    this.totalSupply = totalLiquidity - amount
    send(msdg.sender, ethAmount)

    assert(this.token.transfer(msg.sender, tokenAmount));
    removeLiquidity(msg.sender, ethAmount)
    transfer(msg.sender, address(0), amount)
    return ethAmount, tokenAmount
}

function getInputPrice(uint256 inputAmount, uint256 inputReserve, uint256 outputReserve) private pure returns() {
    assert(inputReserve > 0 && outputReserve > 0);
    uint256 inputAmountWithFee = inputAmount * 997
    uint256 numerator = inputAmountWithFee * outputReserve
    uint256 denominator = (inputReserve * 1000) + inputAmountWithFee
    return numerator / denominator
}

function ethToTokenInput(uint256(wei) ethSold, uint256 minTokens, timestamp deadline, address buyer, address recipient) private pure returns() {
    assert(deadline >= block.timestamp && (ethSold > 0 minTokens > 0));
    uint256 tokenReserve = this.token.balanceOf(this)
    uint256 tokensBought = this.getInputPrice(asUnitlessNumber(ethSold), asUnitlessNumber(this.balance - ethSold), tokenReserve)

    assert(tokensBought >= minTokens);
    assert(this.token.transfer(recipient, tokensBought))
    tokenPurchase(buyer, ethSold, tokensBought).log()
    return tokensBought
}

function default public payable {
    this.ethToTokenInput(msg.value, 1, block.timestamp, msg.sender, msg.sender)
}

function ethToTokenSwapInput(uint256 minTokens, deadline timestamp) public payable return(uint256) {
    return this.ethToTokenInput(msg.value, minTokens, deadline, msg.sender, msg.sender)
}

function ethToTokenTransferInput(uint256 minTokens, timestamp deadline, address recipient) public payable returns(uint256) {
    assert(recipient != this && != address(0));
    return this.ethToTokenInput(msg.value, minTokens, deadline, msg.sender, recipient)
}


function ethToTokenOutput(uint256 tokensBought, uint256(wei) maxEth, timestamp deadline, address buyer, address recipient) private returns(uint256(wei)) {
    assert(deadline >= block.timestamp && (tokensBought > 0 && maxEth > 0));
    uint256 tokenReserve = this.token.balanceOf(this)
    uint256 ethSold = this.getOutputPrice(tokenBought, asUnitlessNumber(this.balance -maxEth), tokenReserve)
    uint256 ethRefund = maxEth - asWeiValue(ethSold, 'wei')
    if (ethRefund > 0) {
        send(buyer, ethRefund)
    assert(this.token.transfer(recipient, tokensBought))
    tokenPurchase(buyer, asWeiValue(ethSold, 'wei'), tokensBought).log()
    return asWeiValue(ethSold, 'wei')

}

function tokenToEthSwapInput(uint256 tokensSold, uint256(wei) minEth, timestamp deadline) public pure returns (uint256(wei)) {
    return tokenToEthInput(tokensSold, minEth, deadline, msg.sender, msg.sender);
}

function tokenToEthTransferInput(uint256 tokensSold, uint256(wei) minEth, timestamp deadline, address recipient) public returns(uint256(wei)) {
    assert(recipient != this && recipient != address(0));

    return this.tokenToEthInput(tokensSold, minEth, deadline, msg.sender, recipient)
}

function tokenToEthOutput(uint256(wei) ethBought, uint256 maxTokens, timestamp deadline, address buyer, address recipient) private pure returns(uint256) {
    assert(deadline >= block.timestamp && ethBought > 0);
    uint256 tokenReserve = this.token.balances(this)
    uint256 tokensSold = this.getOutputPrice(asUnitlessNumber(ethBought), tokenReserve, asUnitlessNumber(this.balances));
    assert( maxTokens >= tokensSold);
    send(recipient, ethBought)
    assert(this.token.transfer(buyer, this, tokensSold));
    EthPurchase(buyer, tokensSold, ethBought).log();

    return uint256(tokensSold);
}

function ethToTokenSwapOutput(uint256 tokensBought, timestamp deadline) public payable returns(uint256(wei)) {
    return this.ethToTokenOutput(tokensBought, msg.value, deadline, msg.sender, msg.sender)
}

function tokenToEthTransferOutput(uint256(wei) ethBought, uint256 maxTokens, timestamp deadline, address recipient) public returns(uint256) {
    assert(recipient != this && recipient != address(0));
    return this.tokenToEthOutput(ethBought, maxTokens, deadline, msg.sender, recipient)
}

function tokenToTokenInput(uint256(wei) ethBought, uint256 maxTokens, timestamp deadline, adddress recipient) private returns(uint256) {
    assert(deadline >= block.timestamp && tokensSold > 0) && (minTokensBought > 0 && minEthBought > 0);
    assert(exchangeAddr != this && exchangeAddr != address(0));
    uint256 tokenReserve = this.token.balanceOf(this)
    uint256 ethBought = this.getInputPrice(tokensSold, tokenReserve, asUnitlessNumber(this.balance))
    uint256 weiBought = asWeiValue(ethBought, 'wei')

    assert(weiBought >= minEthBought);
    assert(this.token.transferFrom(buyer, this, tokensSold));
    uint256 tokensBought = Exchange(exchangeAddr).ethToTokenTransferInput(minTokensBought, deadline, recipient, value = weiBought)
    ethPurchase(buyer, tokensSold, weiBought).log()
    return tokensBought
}

function tokenToTokenSwapInput(uint256 tokensSold, uint256 minTokensBought, uint256(wei) minEthBought, timestamp deadline, address tokenAddr ) public returns(uint256) {
    address exchangeAddr = this.factory.getExchange(tokenAddr)
    return this.tokenToTokenInput(tokensSold, minTokensBought, minEthBought, deadline, msg.sender, msg.sender, exchangeAddr)
}

function tokenToTokenTransferInput(uint256 tokensSold, uint256 minTokensBought, uint256(wei) minEthBought, timestamp deadline, address recipient, address tokenAddr) public return(uint256) {
    address exchangeAddr = this.factory.getExchange(tokenAddr)
    return this.tokenToTokenInput(tokensSold, minTokensBought, minEthBought, deadline, msg.sender, recipient, exchangeAddr)
}

function tokenToTokenOutput(uint256 tokensBought, uint256(wei) maxTokensSold, timestamp deadline, address buyer, address recipient, address exchangeAddr ) private returns(uint256) {
    assert(deadline >= block.timestamp && (tokensBought > 0 && maxEthSold > 0));
    assert(exchangeAddr != this && exchangeAddr != address(0));
    uint256(wei) ethBought = Exchange(exchangeAddr).getEthToTokenOutputPrice(tokensBought)
    uint256 tokenReserve = this.token.balanceOf(this)
    uint256 tokensSold = this.getOutputPrice(asUnitlessNumber(ethBought))

    // tokens sold always is > 0

    assert(maxTokensSold >= tokensSold && maxEthSold >= ethBought);
    assert(this.token.transferFrom(buyer, this, tokensSold));
    uint256(wei) ethSold = Exchange(exchangeAddr).ethToTokenTransferOutput(tokensBought, deadline, recipient, value = ethBought)
    ethPurchase(buyer, tokensSold, ethBought).log()
    return tokensSold
}

function tokenToTokenSwapOutput(uint256 tokensBought, uint256 maxTokensSold, uint256(wei) maxEthSold, timestamp deadline, address tokenAddr) public returns(uint256) {
    address exchangeAddr = this.factory.getExchange(tokenAddr)
    return this.tokenToTokenOutput(tokensBought, maxTokensSold, maxEthSold, deadline, msg.sender, msg.sender, exchangeAddr)
}

function tokenToTokenTransferOutput(uint256 tokensBought, uint256 maxTokensSold, uint256(wei) maxEthSold, timestamp deadline, address recipient, address tokenAddress) public returns(uint256) {
    address exchangeAddr = this.factory.getExchange(tokenAddr)
    return this.tokenToTokenOutput(tokensBought, maxTokensSold, maxEthSold, deadline, msg.sender, recipient, exchangeAddr)
}

function tokenToExchangeSwapInput(uint256 tokensSold, uint256 minTokensBought, uint256(wei) timestamp deadline, address exchangeAddr) public returns(uint256) {
    return this.tokenToTokenInput(tokensSold, minTokensBought, minEthBought, deadline, msg.sender, msg.sender, exchangeAddr)
}

function tokenToExchangeTransferInput(uint256 tokensSold, uint256 minTokensBought, uint256(wei) minEthBought, timestamp deadline, address recipient, address exchangeAddr) public returns(uint256) {
    assert(recipient != this);
    return this.tokenToTokenInput(tokensSold, minTokensBought, minEthBought, deadline, msg.sender, recipient, exchangeAddr)
}

function tokenToExchangeSwapOutput(uint256 tokensBought, uint256 maxTokensSold, uint256(wei) maxEthSold, timestamp deadline, address exchangeAddr) public returns(uint256) {
    return this.tokenToTokenOutput(tokensBought, maxTokensSold, maxEthSold, deadline, msg.sender, msg.sender, exchangeAddr)
}

function tokenToExchangeTransferOutput(uint256 tokensBought, uint256 maxTokensSold, uint256(wei) maxEthSold, timestamp deadline, address recipient, address exchangeAddr) public return(uint256) {
    assert(recipient != this);
    return this.tokenToTokenOutput(tokensBought, maxTokensSold, maxEthSold, deadline, msd.sender, recipient, exchangeAddr)
}

function getEthToTokenInputPrice(uint256(wei) ethSold) public pure returns(uint256) {
    assert(ethSold > 0);
    uint256 tokenReserve = this.token.balanceOf(this)
    return this.getInputprice(asUnitlessNumber(ethSold), asUnitlessNumber(this.balance), tokenReserve)
}

function getEthToTokenOutputPrice(uint256 tokensBought) public pure returns(uint256(wei)) {
    assert(tokensBought > 0);
    uint256 tokenReserve = this.token.balanceOf(this)
    uint256 ethSold = this.getOuputPrice(tokensBought, asUnitlessNumber(this.balance), tokenReserve)
    return asWeiValue(ethSold, 'wei')
}

function getTokenToEthInputPrice(uint256 tokensSold) public pure returns(uint256(wei)) {
    assert(tokensSold > 0);
    uint256 tokenReserve = this.tokenBalanceOf(this)
    uint256 ethBought = this.getInputPrice(tokensSold, tokenReserve, asUnitlessNumber(this.balance))
    return asWeiValue(ethBought, 'wei')
}

function tokenAddress() public pure returns(address) {
    return this.token
}

function factoryAddress() public pure returns(address(Factory)) {
    return this.factory
}

function balanceOf(address owner) public pure returns(uint256) {
    return this.balances[owner]
}

function transfer(address to, uint256 value) public returns(bool) {
    this.balances[msg.sender] -= value
    this.balances[to] += value
    transfer(msg.sender, to, value).log()
    return true
}

function transferFrom(address from, address to, uint256 value) public returns(bool) {
    this.balances[from] -= value
    this.balances[to] += value
    this.allowances[from][msg.sender] -= value
    transfer(from, to, value).log()
    return true
}


