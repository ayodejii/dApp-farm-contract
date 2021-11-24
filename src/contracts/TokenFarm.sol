// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

import "./DaiToken.sol";
import "./DappToken.sol";

contract TokenFarm {
    string public name = "TokenFarm";
    DaiToken private daiToken;
    DappToken private dappToken;
    mapping(address => uint) public daiStakeBalance; //amount of dai this individaul has staked in the farm
    mapping(address => bool) public hasStaked; //flag that checks if the person has staked before
    mapping(address => bool) public isStaking; //flag that checks if the person is currently staking
    address[] public stakers;
    address private owner;

    constructor(DaiToken _daiToken, DappToken _dappToken) {
        daiToken = _daiToken;
        dappToken = _dappToken;
        owner = msg.sender;
    }

    function getName() public view returns (string memory) {
        return name;
    }


    //stake token (deposit)
    function stakeToken(uint amount) public {
        require(amount > 0, "the amount must be greater than zero");
        //transfer dai from user to this farm
        daiToken.transferFrom(msg.sender, address(this), amount);
        //update their dai stake balance
        daiStakeBalance[msg.sender] = daiStakeBalance[msg.sender] + amount;
        
        // add them to list of stakers if they have staked at most once
        if(!hasStaked[msg.sender])
            stakers.push(msg.sender);

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }
    //unstake token (withdraw)
    function unstakeTokens() public {
        //get the balance of the caller
        uint balance = daiStakeBalance[msg.sender];
        //check if balacne is more than 0
        require(balance > 0, "balance must be more than 0");
        //transfer all balance
        daiToken.transfer(msg.sender, balance);
        //set isstaking to false
        daiStakeBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }


    //earn interest - issue tokens
    function issueTokens() public{
        require(msg.sender == owner, "caller must be the owner");
        for (uint256 i = 0; i < stakers.length; i++) {
            address receipient = stakers[i];
            uint balance = daiStakeBalance[receipient];
            if(balance > 0)
                dappToken.transfer(receipient, balance);
        }
    }
}