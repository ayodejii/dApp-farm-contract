// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../src/contracts/TokenFarm.sol";

contract TokenFarmTest {


    function test_contract_has_the_right_name() public {
        
        TokenFarm tokenFarm = TokenFarm(DeployedAddresses.TokenFarm());
        
        //string expectedName = "TokenFarm";
        
        string memory actualName = tokenFarm.getName();
        
        Assert.equal(actualName, "TokenFarm", "because the contract name shold be correct");
    }
}