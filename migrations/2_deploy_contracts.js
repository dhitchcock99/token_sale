var DCToken = artifacts.require("DCToken.sol");
var DCTokenSale = artifacts.require("DCTokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(DCToken, 1000000).then(function() {
  	// Token price is 0.001 Ether
  	var tokenPrice = 1000000000000000;
    return deployer.deploy(DCTokenSale, DCToken.address, tokenPrice);
  });
};
