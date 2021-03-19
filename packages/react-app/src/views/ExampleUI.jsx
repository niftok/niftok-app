/* eslint-disable jsx-a11y/accessible-emoji */

import React, { useState } from "react";
import { Button, List, Divider, Input, Card, DatePicker, Slider, Switch, Progress, Spin } from "antd";
import { SyncOutlined } from '@ant-design/icons';
import { Address, Balance, Url } from "../components";
import { parseEther, formatEther } from "@ethersproject/units";


export default function ExampleUI({purpose, setPurposeEvents, address, mainnetProvider, userProvider, localProvider, yourLocalBalance, price, tx, readContracts, writeContracts }) {


  return (
    <div>
      {/*
        ⚙️ Here is an example UI that displays and sets the purpose in your smart contract:
      */}
      <div style={{border:"1px solid #cccccc", padding:16, width:400, margin:"auto",marginTop:64}}>
        <h2>Minting:</h2>

        <h4>purpose: Mint an NFT for a tik-tok of your choice</h4>

        <Divider/>

        <div style={{margin:8}}>
          <Input type="text" name='Tik-Tok URL' />
          <Button onClick={()=>{
            /*
              ⚙️ Kadin will have to add the hook function that displays the embed on button click
            */
            console.log('filler')
          }}>Display Tik-Tok</Button>
        </div>


      </div>



      <div style={{ width:600, margin: "auto", marginTop:32, paddingBottom:256 }}>


        <Card style={{marginTop:32}}>


          <div style={{marginTop:32}}>
            <Slider range defaultValue={[20, 50]} onChange={()=>{}}/>
          </div>



        </Card>




      </div>


    </div>
  );
}
