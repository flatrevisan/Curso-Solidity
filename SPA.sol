// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract SPA 
{
    string public buyer;
    string public seller;
    uint256 private purchasePrice;
    uint256 public penalty;
    uint256 public equity;
    uint256 constant interestRate = 1;
    
    constructor (
        string memory paramBuyer,
        string memory paramSeller,
        uint256 paramPrice,
        uint256 paramPenalty,
        uint256 paramEquity // Equity purchased by Buyer
    )
    public
    {
        buyer = paramBuyer;
        seller = paramSeller;
        purchasePrice = paramPrice;
        penalty = paramPenalty;
        equity = paramEquity;
    }
    
    function simulPenalty (uint256 numberOfDays, uint256 unpaidAmount) public view returns (uint256 penaltyAmount)
    {
        if (numberOfDays <= 30)
        {
            numberOfDays = 30;
        }
        penaltyAmount = (unpaidAmount * penalty)/100;
        penaltyAmount = penaltyAmount + (((numberOfDays/30*interestRate)*(penaltyAmount+unpaidAmount))/100);
    }
    
    function shareValue (uint256 numberOfShares) public view returns (uint256 sharePrice)
    {
        sharePrice = purchasePrice/numberOfShares;
    }
    
    function guaranteeChoice () public view returns (uint8)
    {
        if (equity == 100){
            return 1; //Escrow Account
        } else {
            return 2; // Pledge of Shares
        }
    }
    
    function guaranteeValue (uint256 numberOfShares) public view returns (uint256 guarantee)
    {    
        if (guaranteeChoice() == 1)
        {
            guarantee = (20 * purchasePrice)/100;
        } else {
            guarantee =  (100 - equity) * shareValue(numberOfShares);
        }
    }
    function shareValue (uint256 numberOfShares) public view returns (uint256 sharePrice)
    {
        sharePrice = purchasePrice/numberOfShares;
    }
}
