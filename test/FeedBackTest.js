const FeedBack = artifacts.require("./FeedBack.sol");
const Token    = artifacts.require("./HumanStandardToken.sol")
contract("FeedBack Token", accounts => {
  it("create an Item and review", async () => {
    const FD = await FeedBack.deployed();
    const FDaddress=FD.address
    const TK = await Token.deployed();

    await TK.transfer(FDaddress,10**6,{from:accounts[0]})

    await FD.createItem("panera",1,{from:accounts[0]})
    await FD.createItem("taco bell",1,{from:accounts[0]})
    await FD.createItem("WacArnolds",1,{from:accounts[0]})
      await FD.createItem("KFC",1,{from:accounts[0]})
    console.log("created")
    await FD.registerUser(accounts[1],{from:accounts[[0]]})
    await FD.registerUser(accounts[2],{from:accounts[[0]]})
     console.log("registered")

    await FD.createReview("that sucked","part2",0,{from:accounts[1]})
    await FD.createReview("tacos are good","part2",1,{from:accounts[2]})
    console.log("reviews ")
    var Item1=await FD.getItemDetail(0);
    console.log(Item1+" item 0")
    console.log(await FD.getItemDetail(1)+"  item 1")
    await FD.upvote(0,{from:accounts[1]})
    await FD.upvote(0,{from:accounts[2]})
    console.log(await FD.getUserPoints(accounts[1]) +"  user points" )
    console.log(await FD.getReviewDetails(0)+" review details")
    console.log("finished")
    var result= await FD.redeemPoints({from:accounts[1]})
    console.log(await TK.balanceOf(accounts[1]))
  });
});
