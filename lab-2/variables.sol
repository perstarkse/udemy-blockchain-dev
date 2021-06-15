pragma solidity ^0.5.13;

contract WorkingWithVariables {
    uint256 public myUint;
    
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
    
    bool public myBool;
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    uint8 public myUint8;
    
    function incrementUint() public {
        myUint8 ++;
    }
    
    function decrementUint() public {
        if(myUint8 == 0) {} 
           else {myUint8 --;}
    }
    address public myAddress;
    
    function setAddress(address _address) public {
        myAddress = _address;
    }
    
    function getBalanceOfAddress() public view returns (uint)  {
        return (myAddress.balance / 1e18);
    }
    
    string public myString = 'hello world';
    
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}
