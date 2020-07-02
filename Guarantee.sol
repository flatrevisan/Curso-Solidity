    
    function guaranteeChoice () public view returns (string memory)
    {
        if (equity == 100){
            return "Escrow Account";} 
        else {
            return "Pledge of Shares";
        }
    }
    
    function guaranteeValue () public view returns (uint256 guarantee)
    {    
        if (guaranteeChoice == "Escrow Account")
        {
            guarantee = (20 * purchasePrice)/100;}
        else 
        {
            guarantee =  (100 - equity) * shareValue;}
    }
