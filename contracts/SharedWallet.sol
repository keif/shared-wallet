//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SharedWallet {
    function receiveMoney() public payable {}

    function withdrawMoney(address payable _to, uint256 _amount) public {
        _to.transfer(_amount);
    }

    receive() external payable {
        receiveMoney();
    }
}
