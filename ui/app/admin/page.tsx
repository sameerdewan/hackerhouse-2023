'use client'
import React, { useEffect, useState } from 'react';
import Web3 from 'web3';
import { Contract } from 'ethers';
import {contractAbi} from '../abi';

function adminPage () {

    const mycontractAbi = contractAbi;
    const contractAddress = '0xeF06dB1BF52AB434d7bB0c9cF9dcbE61536fa6F0'; 
    const [web3, setWeb3] = useState<Web3 | null>(null);
    const [contract, setContract] = useState<Contract | null>(null);
    
    useEffect(() => {
      if (window.ethereum) {
        const web3Instance = new Web3(window.ethereum);
        setWeb3(web3Instance);
    
        const contractInstance = new web3Instance.eth.Contract(mycontractAbi, contractAddress);
        setContract(contractInstance as unknown as Contract);
    }
    }, []);
  
  const mintCarbonCredit = async () => {
    if (contract) {
      // Collect your inputs
      const element = document.getElementById('uuid');
      if (element instanceof HTMLInputElement) {
        const uuid = element.value;
            // ... other inputs
        }

      // Use the contract method you want to call
      // Replace 'yourMethod' and 'yourParams' with your actual method name and parameters
      await contract.methods.mintCarbonLink.send({ from: contractAddress });
    }
  };// replace with your contract address
    return (
        <div className="flex justify-center w-full">
        <div className="bg-white p-8 rounded-lg shadow-md w-96">
         {/* Card Header */}
         <h2 className="text-2xl font-semibold mb-4">Carbon Credit Form</h2>
   
         {/* Form Grid */}
         <div className="space-y-4">
           {/* UUID Input */}
           <div>
             <label htmlFor="uuid" className="block text-sm font-medium text-gray-700">UUID</label>
             <input type="text" name="uuid" id="uuid" placeholder="Enter UUID" className="mt-1 p-2 w-full border rounded-md" />
           </div>
   
           {/* Metric Tons CO2 Input */}
           <div>
             <label htmlFor="metricTonsCO2" className="block text-sm font-medium text-gray-700">Metric Tons CO2</label>
             <input type="number" name="metricTonsCO2" id="metricTonsCO2" placeholder="Enter Metric Tons CO2" className="mt-1 p-2 w-full border rounded-md" />
           </div>
   
           {/* Price Input */}
           <div>
             <label htmlFor="price" className="block text-sm font-medium text-gray-700">Price</label>
             <input type="number" name="price" id="price" placeholder="Enter Price" className="mt-1 p-2 w-full border rounded-md" />
           </div>
   
           {/* Risk Rating Input */}
           <div>
             <label htmlFor="riskRating" className="block text-sm font-medium text-gray-700">Risk Rating</label>
             <input type="number" name="riskRating" id="riskRating" placeholder="Enter Risk Rating" className="mt-1 p-2 w-full border rounded-md" />
           </div>
         </div>
   
         {/* Button */}
         <div className="mt-6">
           <button
           onClick={ mintCarbonCredit}
            className="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium p-2 rounded-md">Mint Carbon Credit</button>
         </div>
       </div>
   
         </div>
    )
}

export default adminPage