pragma solidity ^0.6.0;
import "./ItemManager.sol";

contract Item {
    uint256 public priceInWei;
    uint256 public pricePaid;
    uint256 public index;

    ItemManager parentContract;

    constructor(
        ItemManager _parentContract,
        uint256 _priceinWei,
        uint256 _index
    ) public {
        priceInWei = _priceinWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        require(pricePaid == 0, "item is paid already");
        require(priceInWei == msg.value, "only full payments");
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call.value(msg.value)(
            abi.encodeWithSignature("triggerPayment(uint256)", index)
        );
        require(success, "wasnt successfull yo");
    }

    fallback() external {}
}
