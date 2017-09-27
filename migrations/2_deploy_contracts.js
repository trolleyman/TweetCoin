var Owned = artifacts.require("./Owned.sol");
var TweetCoin = artifacts.require("./TweetCoin.sol");

module.exports = function(deployer) {
	deployer.deploy(Owned);
	deployer.link(Owned, TweetCoin);
	deployer.deploy(TweetCoin);
};
