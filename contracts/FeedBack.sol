pragma solidity ^0.4.10;

import "./Token.sol";

contract FeedBack{

  constructor(address _token,uint _categories){
  owner=msg.sender;
  tk=Token(_token);
  categories=_categories;
  totalItems=0;
  totalreviews=0;
  }

address owner;
uint categories;
uint totalItems;
mapping(uint=>string) categoryDescription;
mapping(address=>User) UserMap;
mapping(address=>uint[]) reviewIds;
mapping(address=>uint) lastVoteTime;
mapping(uint=>Item) ItemMap;
uint totalreviews;
Token tk;



struct Item{
  string name;
	uint category;
	uint totalItemReviews;

	mapping(address=>bool) hasReviewed;
	mapping(uint=>Review) reviews;
}

struct Review{
    uint id;
	address creator;
	string  contents;
	uint upvotes;
	uint downvotes;

}
struct User{

    uint coinpoints;
    bool registered;
}
modifier isOwner(){
	require(msg.sender==owner);
	_;
}
modifier isRegistered(){
	require(UserMap[msg.sender].registered==true);
	_;
}
modifier VoteTimeOut(){
	uint interval=now-lastVoteTime[msg.sender];
	require(interval>86400);
  _;
}

function createReview(string _contents,uint _item) isRegistered(){

	Item storage temp= ItemMap[_item];
	require(temp.hasReviewed[msg.sender]==false);
  reviewIds[msg.sender].push(totalreviews);
	uint total=temp.totalItemReviews;
	temp.reviews[total]=Review(totalreviews,msg.sender,_contents,0,0);
 	totalreviews=totalreviews+1;
 	temp.totalItemReviews+=1;
}

function createItem(string _name,uint _category) isOwner(){
	//bytes32 ID=sha3(_name,totalitems);
  require(_category<=categories);
	ItemMap[totalItems]=Item(_name,_category,0);
	totalItems=totalItems+1;
}


function registerUser(address a) isOwner(){
	User memory temp=User(0,true);
}

function redeemPoints(){
	uint points=UserMap[msg.sender].coinpoints;
	UserMap[msg.sender].coinpoints=0;
	tk.transfer(msg.sender,points);
}

function upvote(uint _id,uint _item) VoteTimeOut() isRegistered(){
	Item temp= ItemMap[_id];
	Review r=temp.reviews[_item];
	r.downvotes+=1;
	User memory rowner=UserMap[r.creator];
	rowner.coinpoints+=1;
}

function downvote(uint _id,uint _item) VoteTimeOut() isRegistered(){
	Item temp= ItemMap[_id];
	Review r=temp.reviews[_item];
	r.upvotes+=1;
	User memory rowner=UserMap[r.creator];
	rowner.coinpoints-=1;

}

function getItemDetail(uint ID) constant returns(string,uint,uint){
return(ItemMap[ID].name,ItemMap[ID].category,ItemMap[ID].totalItemReviews);
}

function getReviewDetails(uint _item,uint _review) constant returns(uint,address,string,uint,uint){
 Review memory temp=ItemMap[_item].reviews[_review];
 return(temp.id,temp.creator,temp.contents,temp.upvotes,temp.downvotes);
}
function getTotalItems() returns(uint){
  return totalItems;
}
function getTotalReviews() returns(uint){
  return totalreviews;
}
}
