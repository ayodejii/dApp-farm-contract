// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "truffle/AssertBool.sol";
import "../../src/contracts/TokenFarm.sol";
import "../../src/contracts/DappToken.sol";
import "../../src/contracts/DaiToken.sol";

contract TokenFarmTest {

    TokenFarm tokenFarm;
    DappToken dappToken;
    DaiToken daiToken;
    uint ethAmount;

    function beforeEach() public {
    
    address thisAddress = address(this); 
    ethAmount = 1_000_000_000000000000000000;

    daiToken = new DaiToken();
    dappToken = new DappToken();

    tokenFarm = new TokenFarm(daiToken, dappToken);
    dappToken.transfer(address(tokenFarm), ethAmount);
    daiToken.transfer(thisAddress, ethAmount);

  }

    // function toWei(uint num) public returns (uint){
    //     return num * 1 wei;
    // }

    function test_contract_has_the_right_name() public {
        
        string memory actualName = tokenFarm.getName();
        
        Assert.equal(actualName, "TokenFarm", "because the contract name shold be correct");
    }

    function test_that_tokenFarm_Has_1million_dapp_after_migration() public{
        uint balance = dappToken.balanceOf(address(tokenFarm));
        Assert.equal(balance, ethAmount, "because 1m eth was sent to it");
    }

    function test_that_investor_Has_1million_dai_after_migration() public{
        uint thisAddressBalance = daiToken.balanceOf(address(this));
        Assert.equal(thisAddressBalance, ethAmount, "because 1m eth was sent to it");
    }

    function test_that_investor_has_staked_hundred_thou_dai() public{
        uint stakeAmount = 100_000_000000000000000000;
        daiToken.approve(address(tokenFarm), stakeAmount);
        tokenFarm.stakeToken(stakeAmount);
        uint curentDaiBalance = ethAmount - stakeAmount;
        uint thisAddressDaiBalance = daiToken.balanceOf(address(this));
        uint thisAddressDaiStakeAmount = tokenFarm.daiStakeBalance(address(this));
        Assert.equal(curentDaiBalance, thisAddressDaiBalance, "because the investor has staked 1h thou tokens");
        Assert.equal(stakeAmount, thisAddressDaiStakeAmount, "because that is the correct amount staked");
        Assert.isTrue(tokenFarm.hasStaked(address(this)), "because the investor has staked");
    }
}