var HumanStandardToken  = artifacts.require("./HumanStandardToken.sol");
var FeedBack= artifacts.require('./FeedBack.sol')
module.exports = function(deployer) {
    deployer.then(async () => {
  var Deploy=await deployer.deploy(HumanStandardToken,10**10*10**18,"FeedBack",18,"FB");
    var address=Deploy.address
    console.log(address +" this should be a address")
    await  deployer.deploy(FeedBack,address,10)
})
};
