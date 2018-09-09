import React, { Component } from "react";
import CreateReview from "../utils/functions"

import { Col, Form, Button, FormControl } from 'react-bootstrap';

class CreateReview extends compnent{
  state={ReviewData:'',item:0}
  handleMyData = (e) => {
          this.setState({ ReviewData: e.target.value },console.log(this.state.ReviewData));

      }
  handleSubmit=()=>{

  }
render(){
  return (
    <div>
      <Col sm={4} smOffset={2}>
                     <Form horizontal onSubmit={this.handleSubmit}>
                         <h4>Enter Review Details:</h4>


                         <FormControl componentClass="textarea" type="text" rows="3" placeholder="enter data"
                             value={this.state.myData}
                             onChange={this.handleMyData} />
                         <br/>
                         <Button type="submit">Update Details</Button>
                     </Form>
                 </Col>
    </div>

  );


}



}
