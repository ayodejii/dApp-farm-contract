import React, { Component } from 'react'
import Navbar from './Navbar'
import DaiToken from '../abis/DaiToken.json'
import './App.css'
import Web3 from 'web3'

class App extends Component {

  async componentWillMount(){
    await this.loadWeb3();
    await this.loadBlockchainData();
  }

async loadBlockchainData(){
  const web3 = window.web3;
  let accounts = await web3.eth.getAccounts();
  console.log(accounts);
  this.setState({account: accounts[0]})

  const networkId = await web3.eth.net.getId();
  console.log(networkId);

  const daiTokenData = DaiToken.networks[networkId];
  if(daiTokenData){
    const daiToken = new web3.eth.Contract(DaiToken.abi, daiTokenData.address)
    this.setState({daiToken});
    console.log(daiTokenData.address);
    let daiTokenBalance = await daiToken.methods.balanceOf(this.state.account).call();
    console.log("here");
    this.setState({daiTokenBalance: daiTokenBalance.toString()})
    console.log({daiTokenBalance});
  }
  else{
    alert("notdeployed contract")
  }

}
async loadWeb3(){
  if(window.ethereum){
    window.web3 = new Web3(window.ethereum)
    await window.ethereum.enable();
  }
  else if(window.web3){
    window.web3 = new Web3(window.web3.currentProvider)
  }
  else{
    alert("non eth broswer discovered");
  }
}

  constructor(props) {
    super(props)
    this.state = {
      account: '0x0',
      daiToken: {},
      dappToken: {},
      tokenFarm: {},
      daiTokenBalance: "0",
      dappTokenBalance: "0",
      stakingBalance: "0",
      loading: true
    }
  }

  render() {
    return (
      <div>
        <Navbar account={this.state.account} />
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-12 ml-auto mr-auto" style={{ maxWidth: '600px' }}>
              <div className="content mr-auto ml-auto">
                <a
                  href="http://www.dappuniversity.com/bootcamp"
                  target="_blank"
                  rel="noopener noreferrer"
                >
                </a>

                <h1>Hello, World!</h1>

              </div>
            </main>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
