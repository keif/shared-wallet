//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
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
