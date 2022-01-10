// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <8.7.0;

import "./ItemManager.sol";

contract Item {

    uint public priceInWei;
    uint public paidWei;
    uint public index;

    ItemManager parentContract;

    constructor (ItemManager _parentContract, uint _priceInWei, uint _index) public {
        parentContract = _parentContract;
        priceInWei = _priceInWei;
        index = _index;
    }    
    
    receive() external payable {
        require(msg.value == priceInWei, "Only takes full payments.");
        require(paidWei == 0, "Item is already paid.");
        paidWei += msg.value;
        (bool success, ) = address(parentContract).call{value:msg.value} (abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "Delivery of payment did not go through!");
    }

    fallback () external {}

}