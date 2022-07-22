//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SharedWallet {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    function receiveMoney() public payable {}

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    receive() external payable {
        receiveMoney();
    }
}
