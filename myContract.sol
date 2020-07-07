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



//SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.6.10;

contract MyContract{
    //Array - list of information
    uint [] public uintArray = [1,2,3];
    string [] public stringArray = ["apple", "banana", "carrot"];
    string [] public values;
    uint [] [] public array2D = [[1,2,3], [4,5,6]];
    
    function addValue(string memory _value) public
    {
        values.push(_value);
    }
    
    function valueCount () public view returns (uint) {
        return values.length;
    }
    
}


//SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.6.10;

contract MyContract
{
    //State Variables
    uint public myUint = 1;
    int public myInt = 1;
    uint256 public myUint256 = 1;
    uint8 public myUint8 = 1;
    string public myString = "Hello, World";
    bytes32 public myBytes32 = "Hello, World";
    address public myAddress = 0x888cDa7b74D2364FfBA6c27FeFF2237501B85DF6;
    
    struct MyStruct 
    {  
        uint myInt;
        string myString;
    }
    
    MyStruct public myStruct = MyStruct (1, "Hello World");
    
    //Local Variables
    function getValue () public pure returns(uint)
    {
        uint value = 1;
        return value;
    }   
    
//SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.6.10;

contract MyContract 
{
    
//Conditionals
// if and else
    uint [] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address public owner;
    
    constructor () public 
    {
        owner = msg.sender;
    }

    function countEvenNumbers () public view returns (uint)
    {
        uint count = 0;
        
        for (uint i = 0; i <numbers.length; i++) // runs code until the conditional is met
        {
            if (isEvenNumber(numbers[i]))
            {
                count ++;
            }
        }
        return count;
    }

    function isEvenNumber(uint _number) public view returns(bool) 
    {
        if (_number % 2 == 0)
        {
            return true;
        } else {
            return false;
        }
    }

    function isOwner () public view returns (bool)
    {
        if (msg.sender == owner)
        {
            return true;
        } else {
            return false;
        }
    }
    
    function wasOwner () public view returns (bool)
    {
        return (msg.sender == owner);
    }
}
    
