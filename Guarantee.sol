    
     function guaranteeChoice (uint256 pledgeOfShares, uint256 escrowAccount) public view returns (uint256 guarantee)
    {
        if (equity == 0)
        {
            guarantee = escrowAccount; guarantee = pledgeOfShares;
        }
        pledgeOfShares = (equity * purchasePrice);
        escrowAccount =  (20 * purchasePrice)/100;
        return guarantee;
    }
    
}
