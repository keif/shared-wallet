//SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint256;

    function isOwner() public view virtual returns (bool) {
        return msg.sender == owner();
    }

    event AllowanceChanged(
        address indexed _forWho,
        address indexed _byWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );
    mapping(address => uint256) public allowance;

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount)
        internal
        ownerOrAllowed(_amount)
    {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who] - _amount
        );
        allowance[_who] -= _amount;
    }
}
