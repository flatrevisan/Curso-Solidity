//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

    contract StartUpInvestment {
    
    struct Investor 
    {
        string name;
        address payable investorAccount;
        uint offer;
        uint numberOfSharesAcquired;
        uint id;
    }
    
    address payable public companyAccount;
    uint public minimumOfferPerShare;
    uint public sharesAvailable;
    uint public timeLimit;
    bool transactionConfirmation;
    
    constructor
    (
        address payable _companyAccount,
        uint _minimumOfferPerShare,
        uint _sharesAvailable,
        uint _timeLimit
    ) public
    
    {
        companyAccount = _companyAccount;
        minimumOfferPerShare = _minimumOfferPerShare;
        sharesAvailable = _sharesAvailable;
        timeLimit = now + _timeLimit;
    }
    
    event previousID (address, uint);
    event remainingShares (address, uint);
    event bidClosed (address, string);
    
    mapping (uint => Investor) public investorsBids;
    
    function confirmOffer  (string memory _nameOfInvestor, address payable _accountOfInvestor, uint _sharesAcquired, uint _id) payable public
   {
        require (now<= timeLimit, "Share Offer Closed");
        require ((msg.value/_sharesAcquired) > minimumOfferPerShare, "Offer not Accepted.");
        require (_sharesAcquired <= sharesAvailable, "Not enough Shares Available");
        
        sharesAvailable = sharesAvailable - _sharesAcquired;
        
        investorsBids [_id] = Investor (_nameOfInvestor, _accountOfInvestor, msg.value, _sharesAcquired, _id);
        
        emit previousID (msg.sender, _id);
        emit remainingShares (msg.sender, sharesAvailable);
    }
    
    function endBid () payable public
    {
        require (now >= timeLimit, "Bidding Allowed");
        if (sharesAvailable != 0)
            {
                investorsBids[_id].transfer (msg.value);
            
            } else{
                
                companyAccount.transfer(address(this).balance);
             
                emit bidClosed (msg.sender, "Investment fully secured. Congratulations!");
            }
    }
}



0x8AeFe10f532da88392e4EB807718AAB4a504e5F1
