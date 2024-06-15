// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExceptionRequire {
    mapping(address => uint8) public balanceRecived;

    function reciveMoney() public payable {
        assert(msg.value == uint(msg.value));
        balanceRecived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        require(_amount <= balanceRecived[msg.sender], "Not enough funds");
        balanceRecived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
