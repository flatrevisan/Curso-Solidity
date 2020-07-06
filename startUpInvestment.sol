// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract StartUpInvestment 
{
    struct Investor 
    {
        string name;
        address payable investorAccount;
        uint256 offer;
        uint256 numberOfSharesAcquired;
    }
    
    address payable public companyAccount;
    uint256 public minimumOfferPerShare;
    uint256 public sharesAvailable;
    uint256 public timeLimit;
    
    mapping (address => Investor) public investorsBids;
    Investor [] public officialInvestors;
    
    event remainingSharesAvailable (uint valor);
    event bidClosed (string);
    

    constructor
        (
        uint256 _timeLimit,
        address payable _companyAccount,
        uint256 _minimumOfferPerShare,
        uint256 _sharesAvailable
        ) public
        
        {
        timeLimit = now + _timeLimit;
        companyAccount = _companyAccount;
        sharesAvailable = _sharesAvailable;
        minimumOfferPerShare = _minimumOfferPerShare;
        }
 
    
    function investorOffer (string memory _nameOfInvestor, address payable _accountOfInvestor, uint _sharesAcquired) public payable
    {
        require ((msg.value/_sharesAcquired) >= minimumOfferPerShare, "Offer not Accepted");
        require (now <= timeLimit, "Investment Opportunity Closed");
        require (remainingShares >= _sharesAcquired);
    
        for (uint i=0; i<=remainingShares; i++)
        {
            shares = shares + _sharesAcquired;
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
