import React, { Component } from "react";
import { Route, Link,Switch,BrowserRouter  } from 'react-router-dom';
import getWeb3 from "./utils/getWeb3";
import truffleContract from "truffle-contract";
import navbar from "components/navbar/navbar"
import AddUser from "components/AddUser"
import AddItem from "components/AddItem"

import "./App.css";

class App extends Component {




  render() {

    return (
     <BrowserRouter>
    <div>

     {navbar}

     <Switch>
        <Route path="/AddUser"  component={AddUser} />
        <Route path="/AddItem"  component={AddItem} />
      </Switch>

    </div>
     </BrowserRouter>
    );
  }
}

export default App;
