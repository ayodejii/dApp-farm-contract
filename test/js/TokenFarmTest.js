const { assert } = require('chai');

const TokenFarm = artifacts.require('TokenFarm')
const DaiToken = artifacts.require('DaiToken')
const DappToken = artifacts.require('DappToken')

require('chai')
.use(require('chai-as-promised'))
.should();

contract('TokenFarm', (accounts) => {
    let tokenFarm;
    
    before(async () => {
        tokenFarm = await TokenFarm.deployed();
    });

    describe("contract name", async () => {
        it("has the right name", async () => {
            //let tokenFarm = await TokenFarm.new();
            let actualName = tokenFarm.name;
            let expectedName = "TokenFarm";
            assert(expectedName == actualName, "because that is the right name");
        })
        
    })
})