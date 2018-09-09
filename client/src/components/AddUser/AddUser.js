import React, { Component } from "react";
import RegisterUser from "../utils/functions"


class AddUser extends Component{

state={address:''}

handleSubmit=()=>{
RegisterUser(this.state.address)
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
        Enter address
        <input type="text" value={this.state.value} onChange={this.handleChange.bind(this,'name')}></input>
        </label>

        <button>add item</button>


   </div>



  )


}



}
export default AddUser
