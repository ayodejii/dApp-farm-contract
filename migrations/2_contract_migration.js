const TokenFarm = artifacts.require("TokenFarm");
const DaiToken = artifacts.require("DaiToken");
const DappToken = artifacts.require("DappToken");

module.exports = async function(deployer, network, accounts) {

  //accounts is all the addresses from ganache, and we are using it here cos we need to give some dai to an account just for test
  //

  await deployer.deploy(DaiToken);
  const daiToken = await DaiToken.deployed();

  await deployer.deploy(DappToken);
  const dappToken = await DappToken.deployed();

  await deployer.deploy(TokenFarm, daiToken.address, dappToken.address);
  const tokenFarm = await TokenFarm.deployed(); //we assigned the deployed to a variable just so we could use the address from the variable

  //transfer 1 million dapp token to token farm on default so we can distribute to investors later
  await dappToken.transfer(tokenFarm.address, '1000000000000000000000000')

  await daiToken.transfer(accounts[1], '100000000000000000000'); //give token to one of the address on ganache - the second guy i.e. the investor

};

//since the Token Farm contract has a constructr that takes two parameter (dapp and dai), 
//we need to find a way to pass these addresses to the contract, i.e. make it aware of the addresses.
//the way to do this is to import the two addresses here, then pass them to the token farm as it is being deployed to the blockchain
