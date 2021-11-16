// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

import "./DaiToken.sol";
import "./DappToken.sol";

contract TokenFarm {
    string public name = "TokenFarm";
    DaiToken private daiToken;
    DappToken private dappToken;

    constructor(DaiToken _daiToken, DappToken _dappToken) {
        daiToken = _daiToken;
        dappToken = _dappToken;
    }

    function getName() public view returns (string memory) {
        return name;
    }
}