// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract StartUpInvestment 
{
    struct Investor 
    {
        string name;
        address payable investorAccount;
        uint offer;
        uint numberOfSharesAcquired;
    }
    
    address payable public companyAccount;
    uint minimumOfferPerShare;
    uint public sharesAvailable;
    uint public timeLimit;
    
    mapping (address => Investor) public investorsBids;
    Investor [] public officialInvestors;
    
    event remainingSharesAvailable (uint valor);
    event bidClosed (string);
    

    constructor
        (
        uint _timeLimit,
        address payable _companyAccount,
        uint _minimumOfferPerShare,
        uint _sharesAvailable
        ) public
        
        {
        timeLimit = now + _timeLimit;
        companyAccount = _companyAccount;
        sharesAvailable = _sharesAvailable;
        minimumOfferPerShare = _minimumOfferPerShare;
        }
 
    
    function investorOffer (string memory nameOfInvestor, address payable accountOfInvestor, uint sharesAcquired, uint remainingShares, uint shares) public payable
    {
        require ((msg.value/sharesAcquired) >= minimumOfferPerShare, "Offer not Accepted");
        require (now <= timeLimit, "Investment Opportunity Closed");
        require (remainingShares >= sharesAcquired);
    
        for (uint i=0; i<=remainingShares; i++)
        {
            shares = shares + sharesAcquired;
            remainingShares = sharesAvailable - shares;
            if (remainingShares = 0)
            {
                return "Investment Fully Acquired";
            } else{
                return "Investment Required";
                }
        }
        
        Investor storage investorAcquired = Investor (nameOfInvestor, accountOfInvestor, msg.value, sharesAcquired);
        investorsBids.push (investorAcquired);
        officialInvestors [investorAcquired.accountOfInvestor];
    
        emit remainingSharesAvailable (remainingShares);
    }
     
     function endBid () payable public
     {
         if (now>= timeLimit)
         {
             if (remainingShares != 0)
             {
                    nameOfInvestor.accountOfInvestor.transfer(offer);
                    nameOfInvestor.investmentRefunded = true;
                    
                    emit bidClosed ("Investment failed. Thanks for the attempt!");
             }
         } else 
            {
             companyAccount.transfer(address(this).balance);
             
             emit bidClosed ("Investment fully secured. Congratulations!");
            }
        
     }
}   
