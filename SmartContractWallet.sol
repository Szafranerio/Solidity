// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Consumer {
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    function deposit() public payable {}
}

contract SmartContractWallet {
    address payable public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;
    mapping(address => bool) public guardians;
    address payable public nextOwner;
    mapping(address => mapping(address => bool))
        public nextOwnerGuardianVotedBool;
    uint public guardianResetCount;
    uint public constant confirmationFromGuardianReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You are not the owner");
        guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not a guardian of this wallet");
        require(
            !nextOwnerGuardianVotedBool[_newOwner][msg.sender],
            "You already voted!"
        );

        if (_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardianResetCount = 0;
        }

        nextOwnerGuardianVotedBool[_newOwner][msg.sender] = true;
        guardianResetCount++;

        if (guardianResetCount >= confirmationFromGuardianReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner");
        allowance[_for] = _amount;

        if (_amount > 0) {
            isAllowedToSend[_for] = true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(
        address payable _to,
        uint _amount,
        bytes memory _payload
    ) public returns (bytes memory) {
        if (msg.sender != owner) {
            require(
                isAllowedToSend[msg.sender],
                "You are not allowed to use this smart contract"
            );
            require(
                allowance[msg.sender] >= _amount,
                "You want to transfer more than you can"
            );
            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(
            _payload
        );
        require(success, "Aborting, call was not successful");
        return returnData;
    }

    receive() external payable {}
}
