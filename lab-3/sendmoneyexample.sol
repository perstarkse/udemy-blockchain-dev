pragma solidity ^0.8.1;

contract SendMoneyExample {
    
    uint public balanceRecieved;
    uint public lockedUntil;
    
    modifier requireOwner() {
        require(msg.sender == 0xB05ab2c1de77316A9F825759764A1C4aD810d4A4);
        _;
    }
    
    function recieveMoney() public payable {
        balanceRecieved += msg.value;
        lockedUntil = block.timestamp + 1 minutes;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdrawMoney() public requireOwner {
        if(lockedUntil < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer(getBalance());          
        }
    }
    
    function withdrawMoneyTo(address payable _to) public requireOwner {
        if(lockedUntil < block.timestamp) {
            _to.transfer(getBalance());
        } 
    }
    
    function currBlock() public view returns(uint) {
        return(block.timestamp);
    }
}
