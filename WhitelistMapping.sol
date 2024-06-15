// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract whitelistAddress {
    mapping(address => bool) public accessAddressMapping;

    function setAddress(address _index) public {
        accessAddressMapping[_index] = true;
    }
}
