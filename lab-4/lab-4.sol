pragma solidity ^0.8.1;

contract StartStopUpdateExample {
    
    address public owner;
    
    bool public paused;
    constructor() {
        owner = msg.sender;
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner);
        paused = _paused;
    }
    
    function sendMoney() public payable {
        
    }
    
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "you are not the owner");
        require(!paused, "contract is paused"); 
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner);
        selfdestruct(_to);
    }
}
