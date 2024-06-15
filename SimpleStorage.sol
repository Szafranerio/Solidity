//Remember about version!!!
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage {

    //No value after favouriteNumber will result of 0 number
    uint256 favouriteNumber;
   
   mapping (string => uint256) public nameToFavouriteNumber;

    struct People {
        uint256 favouriteNumber;
        string name;
    }

    People [] public people;
    
    function store(uint256 _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
    }

    function retrieve() public view returns (uint256){
        return favouriteNumber;
    }
    
    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        People memory newPerson = People(_favouriteNumber, _name);
        people.push(newPerson);
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }

}
