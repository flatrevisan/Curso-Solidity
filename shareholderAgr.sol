//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract ShareholderAgr {
    
    struct Shareholder
    {
        address payable beneficiary;
        string name;
        uint equity;
        uint shId;
    }
    
    struct Assets
    {
        uint id;
        uint value;
        bool divisible;
    }
    
    mapping (address => Shareholder) shList;
    function storeShList (address payable _beneficiary, string memory _name, uint _equity) public
    {
        uint shId;
        shId = shId + 1;
        shList [msg.sender] = Shareholder (_beneficiary, _name, _equity, shId);
    }
    
}
