//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MappingsStructExample {
    
    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping(address => Balance) public amountPayed;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
    amountPayed[msg.sender].totalBalance += msg.value;
    
    Payment memory payment = Payment(msg.value, block.timestamp);
    amountPayed[msg.sender].payments[amountPayed[msg.sender].numPayments] = payment;
    amountPayed[msg.sender].numPayments++;
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = amountPayed[msg.sender].totalBalance;
        amountPayed[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }
    
    function withdrawSomeMoney(address payable _to, uint _amountToSend) public {
        require(_amountToSend <= amountPayed[msg.sender].totalBalance, "not enough dough"); 
        amountPayed[msg.sender].totalBalance -= _amountToSend;
        _to.transfer(_amountToSend);
    }
}
