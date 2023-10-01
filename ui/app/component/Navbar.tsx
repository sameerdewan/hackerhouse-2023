"use client"

import React, { useEffect, useState } from 'react';
import { Disclosure } from '@headlessui/react';
import Image from 'next/image';
import Web3Modal from 'web3modal';
import Web3 from 'web3';
export default function Navbar() {
    const [web3Modal, setWeb3Modal] = useState<Web3Modal | null>(null);
    const [provider, setProvider] = useState<Web3 | null>(null);
  useEffect(() => {
    const web3Modal = new Web3Modal({
      network: 'mainnet', // optional
      cacheProvider: true, // optional
      providerOptions: {
        walletconnect: {
          package: 'walletconnect',
          options: {
            rpc: process.env.NEXT_PUBLIC_URL // required
          }
        }
      }  // required
    });
    setWeb3Modal(web3Modal);
  }, []);

  const connectWallet = async () => {
    try {
      const provider = await web3Modal!.connect();
      const web3 = new Web3(provider);
      setProvider(web3);
      // You can add more code here to interact with blockchain
    } catch (e) {
      console.error("Could not get a wallet connection", e);
      return;
    }
  };

  return (
    <Disclosure as="nav" className="bg-gray-800 w-full">
      {({ open }) => (
        <>
          <div className="mx-auto px-2 sm:px-6 lg:px-8 w-full flex justify-between items-center h-16">
            <div className="flex items-center">
              <Image
                className="h-8 w-auto"
                src="/carbonLogo.png"
                alt="Your Company"
                height={100}
                width={100}
              />
            </div>
            <button onClick={connectWallet}>Connect Wallet</button>
          </div>
        </>
      )}
    </Disclosure>
  );
}
