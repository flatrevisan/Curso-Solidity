//SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.6.10;

contract HotelRoom 
{
    //Ether - pay smart contracts
    //Modifiers
    //Visibility
    //Events
    //Enums (acompanha status)
    
    address payable public owner;
    
    event Occupy (address _occupant, uint _value);
    
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    
    constructor () public
    {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant
    {
        require (currentStatus == Statuses.Vacant, 'Currently occupied.');
        _;
    }
    
    modifier costs (uint _amount)
    {  
        require (msg.value >= _amount, "Not enough Ether provided.");
        _;
    }
    
    function book2 () payable public onlyWhileVacant costs(2 ether)
    {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy (msg.sender, msg.value);
    }
    
    receive () external payable onlyWhileVacant costs (2 ether)
    {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy (msg.sender, msg.value);
    }    
    
    function book () payable public 
    //check price and check status
    {
        require (msg.value >= 2 ether, "Not enough Ether provided."); 
        require (currentStatus == Statuses.Vacant, "Currently occupied.");
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
    }  
}
