import getWeb3 from "./utils/getWeb3";
import truffleContract from "truffle-contract";
import FeedBack from "FeedBack.json";
import setJSON from "IPFS";
const web3 = await getWeb3();
const accounts = await web3.eth.getAccounts();
const Contract = truffleContract(FeedBack);
Contract.setProvider(web3.currentProvider);
const instance = await Contract.deployed();

console.log(web3)
console.log(instance)

export async function CreateReview(data,item){
     var hash=setJSON(data)
     let part1=hash.slice(0,32)
     let part2=hash.slicd(33,45)
  await instance.createReview(part1,part2,item,{from:accounts[0]})
}

export async function RegisterUser(address){
    await instance.registerUser(address,{from:accounts[[0]]})

}

export async function CreateItem(name,category){
   await instance.createItem(name,category,{from:accounts[0]})
}
export async function GetItemDetails() {

}
export async function ReedemPoints(){

}
export async function upvote(item){
  await instance.upvote(item,{from:accounts[0]})

}
export async function downvote(time){
  await instance.downvote(item,{from:accounts[0]})
}

export async function GetTopReviews(item,amount){

}
