import React from "react";
import { PageHeader } from "antd";

// displays a page header

export default function Header() {
  return (
    <a href="http://pennblockchain.com/" target="_blank" rel="noopener noreferrer">
      <PageHeader
        title="Nif Tok"
        subTitle="mintable NFT's for your favorite tik-toks"
        style={{ cursor: "pointer" }}
      />
    </a>
  );
}
