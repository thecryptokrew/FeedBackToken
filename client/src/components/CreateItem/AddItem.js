import React, { Component } from "react";
import CreateItem from "../utils/functions"


class AddItem extends Component{

state={category:'',name:''}

handleSubmit=()=>{
 var result=CreateItem(this.state.category,this.state.name)
 console.log(result)
}
handleChange = (fieldName, event) => {
  const state = {
    ...this.state,
  };
  state[fieldName] = event.target.value;
  this.setState(state);
  console.log(state)
};
render(){

  return(

   <div>
        <h3>Add an item here</h3>
        <label>
        Enter Item name
        <input type="text" value={this.state.value} onChange={this.handleChange.bind(this,'name')}></input>
        </label>
        <label>
        <input type="text" value={this.state.value} onChange={this.handleChange.bind(this,'category')}></input>
        </label>
        <button>add item</button>


   </div>



  )


}



}
export default AddItem;
