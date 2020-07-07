//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

contract StartUpInvestment {
    
    struct Investor 
    {
        string name;
        address payable investorAccount;
        uint offer;
        uint numberOfSharesAcquired;
    }
    
    address payable public companyAccount;
    uint public minimumOfferPerShare;
    uint public sharesAvailable;
    uint public timeLimit;
    
    mapping (address => Investor) investorsBids;
    
    event remainingSharesAvailable (uint);
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
 
    
    function investorOffer (string memory _nameOfInvestor, address payable _accountOfInvestor, uint _offerAmount, uint _sharesAcquired) public payable
    {
        uint remainingShares = sharesAvailable;
        
        require ((msg.value/_sharesAcquired) >= minimumOfferPerShare, "Offer not Accepted");
        require (remainingShares >= _sharesAcquired, "Investment Fully Acquired");
        _offerAmount = msg.value;
        
        for (uint i=0; i<=remainingShares; i++)
        {
            if (now <= timeLimit)
            {
                remainingShares = remainingShares - _sharesAcquired;
                investorsBids [_accountOfInvestor] = Investor (_nameOfInvestor, _accountOfInvestor, _offerAmount, _sharesAcquired);
                
                emit remainingSharesAvailable (remainingShares);
            
                
            } else {
                if (remainingShares != 0)
                {
                _accountOfInvestor.transfer(_offerAmount);
                    
                emit bidClosed ("Investment failed. Thanks for the attempt!");
                } else {
                    companyAccount.transfer(address(this).balance);
             
                    emit bidClosed ("Investment fully secured. Congratulations!");
                }
            }
        }
    }
}   
