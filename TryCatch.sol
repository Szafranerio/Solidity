// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract willThrow {
    function aFunction() public pure {
        require(false, "Error message");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    function catchTheError() public {
        willThrow will = new willThrow();
        try will.aFunction() {
            //add code here if works
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}
