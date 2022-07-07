pragma solidity ^0.8.3;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract SharedWallet {
    
    using SafeMath for uint;
    
    address private owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "you are not allowed");
        _;
    }
    
    modifier isRestricted(address _account) {
        require(isAdminRestricted[_account] == false, 'you are restricted by admin');
        _;
    }
    
    mapping(address => bool) public isAdminRestricted;
    mapping(address => uint) public etherBalance;
    mapping(address => uint) public allowance;
    
    event newAllowance(uint indexed _amount, address indexed _account);
    event gotRestricted(address indexed _account);
    
    function setisAdminRestricted(address _account) public onlyOwner {
        isAdminRestricted[_account] = true;
        emit gotRestricted(_account);
    }
    
    function depositEther() public payable {
        etherBalance[msg.sender] = etherBalance[msg.sender].add(msg.value);
    }
    
    function withdrawTokens(uint _amount) public isRestricted(msg.sender) {
        etherBalance[msg.sender] = etherBalance[msg.sender].sub(_amount);
        address payable i = payable(msg.sender);
        i.transfer(_amount);
    }
    
    function ownerMoveTokens(uint _amount, address _account) public onlyOwner {
        etherBalance[_account] = etherBalance[_account].sub(_amount);
        etherBalance[owner] = etherBalance[owner].add(_amount);
    }
    
    function sendTokens(uint _amount, address _to) public isRestricted(msg.sender) {
        etherBalance[msg.sender] = etherBalance[msg.sender].sub(_amount);
        etherBalance[_to] = etherBalance[_to].add(_amount);
    }
    
    function setAllowance(uint _amount, address _account) public onlyOwner {
        allowance[_account] += _amount;
        emit newAllowance(_amount, _account);
    }
    
    function getAllowance() public isRestricted(msg.sender) {
        etherBalance[owner] = etherBalance[owner].sub(allowance[msg.sender]);
        etherBalance[msg.sender] = etherBalance[msg.sender].add(allowance[msg.sender]);
        allowance[msg.sender] = allowance[msg.sender].sub(allowance[msg.sender]);
    }
    
} 
