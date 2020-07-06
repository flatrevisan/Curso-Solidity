pragma solidity 0.6.10;

contract MyContract
{
    mapping (uint => string) public names;
    mapping (uint => Book) public books;
    mapping(address => mapping(uint => Book)) public myBooks;
    
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
    
    function addMyBook(uint _id, string memory _title, string memory _author) public
    {
        myBooks[msg.sender] [_id]= Book(_title, _author);
    }
}
