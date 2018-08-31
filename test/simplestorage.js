const FeedBack = artifacts.require("./FeedBack.sol");
const Token    = artifacts.require("./HumanStandardToken.sol")
contract("FeedBack Token", accounts => {
  it("create an Item and review", async () => {
    const FD = await FeedBack.deployed();
    const FDaddress=FD.address
    const TK = await Token.deployed();

    await TK.transfer(FDaddress,10**6,{from:accounts[0]})
    console.log("transfer")
    await FD.createItem("iphone",1,{from:accounts[0]})
    await FD.registerUser(accounts[1],{from:accounts[[0]]})
    //await FD.createReview("that sucked",0,{from:accounts[1]})
  });
});
