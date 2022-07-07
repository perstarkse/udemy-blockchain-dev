pragma solidity ^0.8.3;

contract FunctionsExample {
    
    mapping(address => uint) public balanceRecieved;
    
    address payable owner;
    
    constructor() {
        owner = payable(msg.sender);
    }
    
    receive() external payable {
        recieveMoney();
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function convertWeiToEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }
    
    function destroySmartContract() public {
        require(msg.sender == owner, "you are not the owner");
        selfdestruct(owner);
    }
    
    function recieveMoney() public payable {
        assert(balanceRecieved[msg.sender] + msg.value >= balanceRecieved[msg.sender]);
        balanceRecieved[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceRecieved[msg.sender], 'not enough dough');
        assert(balanceRecieved[msg.sender] >= balanceRecieved[msg.sender] - _amount);
        balanceRecieved[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    

}
