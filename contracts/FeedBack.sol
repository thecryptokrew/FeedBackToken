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
uint public categories;
uint public totalItems;
mapping(uint=>string) categoryDescription;
mapping(address=>User) UserMap;
mapping(address=>uint[]) reviewIds;
mapping(address=>uint) lastVoteTime;
mapping(uint=>Item) ItemMap;
mapping(uint=>Review) reviewMap;
mapping(uint=>Item[]) itemInCategory;
mapping(uint=>uint) RatioID;
mapping(uint=>Review[]) ItemReviews;
uint public totalreviews;
Token tk;




struct Item{
  string name;
	uint category;
	uint totalItemReviews;

	mapping(address=>bool) hasReviewed;

}

struct Review{
    uint id;
	address creator;
	string  contents;
  string contents2;
	uint upvotes;
	uint downvotes;
  uint voteRatio;
}
struct User{

    int coinpoints;
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

function createReview(string _contents,string _contents2,uint _item) isRegistered(){

	Item storage temp= ItemMap[_item];
	require(temp.hasReviewed[msg.sender]==false);
  reviewIds[msg.sender].push(totalreviews);

	uint total=temp.totalItemReviews;
	ItemReviews[_item].push(Review(totalreviews,msg.sender,_contents,_contents2,0,0,0));
  reviewMap[totalreviews]=Review(totalreviews,msg.sender,_contents,_contents2,0,0,0);

 	totalreviews=totalreviews+1;
 	temp.totalItemReviews+=1;

}

function createItem(string _name,uint _category) isOwner(){
	//bytes32 ID=sha3(_name,totalitems);
  require(_category<=categories);
  Item memory tempItem;
  tempItem.name=_name;
  tempItem.category=_category;
	tempItem.totalItemReviews=0;
  ItemMap[totalItems]=tempItem;
  itemInCategory[_category].push(tempItem);
	totalItems=totalItems+1;
}


function registerUser(address a) isOwner(){
	User memory temp=User(0,true);
  UserMap[a]=temp;
}

function redeemPoints(){

	uint points=uint(UserMap[msg.sender].coinpoints);
  require(points>0);
	UserMap[msg.sender].coinpoints=0;
	tk.transfer(msg.sender,points);
}

function upvote(uint _id) VoteTimeOut() isRegistered(){
	Review memory r=reviewMap[_id];
	r.upvotes+=1;

	User storage rowner=UserMap[r.creator];
	rowner.coinpoints+=1;
}

function downvote(uint _id) VoteTimeOut() isRegistered(){
		Review memory r=reviewMap[_id];
	r.downvotes+=1;
	User memory rowner=UserMap[r.creator];
	rowner.coinpoints-=1;

}

function getItemDetail(uint ID) constant returns(string,uint,uint){
return(ItemMap[ID].name,ItemMap[ID].category,ItemMap[ID].totalItemReviews);
}

function getReviewDetails(uint _review) constant returns(uint,address,string,uint,uint){
 Review memory temp=reviewMap[_review];
 return(temp.id,temp.creator,temp.contents,temp.upvotes,temp.downvotes);
}



function getUserPoints(address a) constant returns(int){
  return UserMap[a].coinpoints;
}
function stringToBytes32(string memory source) constant returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
}

function returnTopReviews(uint start,uint end,uint _item) constant returns(bytes32[200],uint[],uint[],uint[]){
        require((end-start)<=100);
        require((end<ItemReviews[_item].length));
        Review[] memory reviews=ItemReviews[totalItems];
        quickSort(reviews, int(0), int(reviews.length - 1));
        Review memory temp;
        uint[] memory _upvotes;
        uint[] memory _downvotes;
        uint[] memory _ratio;
        bytes32[200] memory info;

        while(start<end){
         temp=reviews[start];
         info[2*(start)]=stringToBytes32(temp.contents);
         info[2*(start)+1]=stringToBytes32(temp.contents2);
         _upvotes[start]=temp.upvotes;
         _downvotes[start]=temp.downvotes;
         _ratio[start]=temp.voteRatio;
          start++;
        }
        return(info,_upvotes,_downvotes,_ratio);
    }
function returnMostPopularItems(uint start,uint end, uint _category) constant returns(bytes32[100],uint[]){
  require((end-start)<=100);
  require((end<itemInCategory[_category].length));
  Item[] memory items=itemInCategory[_category];
  quickSort(items, int(0), int(items.length - 1));
  bytes32[100] memory info;
  Item memory temp;
  uint[] totalR;
  while(start<end){
     temp=items[start];
     totalR[start]=temp.totalItemReviews;
     info[start]=stringToBytes32(temp.name);
     start++;
  }
}

       function quickSort(Review[] memory arr, int left, int right) internal{
           int i = left;
           int j = right;
           if(i==j) return;
           uint pivot = arr[uint(left + (right - left) / 2)].voteRatio;
           while (i <= j) {
               while (arr[uint(i)].voteRatio < pivot) i++;
               while (pivot < arr[uint(j)].voteRatio) j--;
               if (i <= j) {
                   (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                   i++;
                   j--;
               }
           }
           if (left < j)
               quickSort(arr, left, j);
           if (i < right)
               quickSort(arr, i, right);
       }
       function quickSort(Item[] memory arr, int left, int right) internal{
           int i = left;
           int j = right;
           if(i==j) return;
           uint pivot = arr[uint(left + (right - left) / 2)].totalItemReviews;
           while (i <= j) {
               while (arr[uint(i)].totalItemReviews < pivot) i++;
               while (pivot < arr[uint(j)].totalItemReviews) j--;
               if (i <= j) {
                   (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                   i++;
                   j--;
               }
           }
           if (left < j)
               quickSort(arr, left, j);
           if (i < right)
               quickSort(arr, i, right);
       }




}
