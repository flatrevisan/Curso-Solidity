//SPDX-License-Identifier: CC-BY-4.0//
pragma solidity 0.6.10;

contract MyContract
{
    mapping (uint => string) public names;
    mapping (uint => Book) public books;
    
    struct Book 
    {
        string title;
        string author;
    }
    
    constructor () public
    {
        names[1] = "Adam";
        names[2] = "Carl";
        names[3] = "Bruce";
    }
    
    function addBook (uint _id, string memory _title, string memory _author) public
    {
        books[_id] = Book (_title, _author);
    }
}
