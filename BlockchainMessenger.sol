// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract BlockchainMessenger {
    uint public changeCounter; //count how many times message was changed
    address public owner;
    string public theMessage;

    constructor() {
        owner = msg.sender;
    }

    function updateTheMessage(string memory _newMessage) public {
        if (msg.sender == owner) {
            theMessage = _newMessage;
            changeCounter++;
        }
    }
}
