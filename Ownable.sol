
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <8.10.0;

contract Ownable {
    address public _owner;

    constructor () public {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "You are not the owner!");
        //This specifies when function needs to be executed 
        _;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == _owner);
    }
}
