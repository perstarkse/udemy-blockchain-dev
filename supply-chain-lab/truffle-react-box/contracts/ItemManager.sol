import "./Item.sol";
import "./Ownable.sol";

contract ItemManager is Ownable {
    enum SupplyChainState {
        Created,
        Paid,
        Delivered
    }

    struct item_template {
        Item _item;
        string _id;
        uint256 _price;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint256 => item_template) public items;

    uint256 itemIndex;

    event SupplyChainStep(
        uint256 _itemIndex,
        uint256 _step,
        address _itemAddress
    );

    function createItem(string memory _identifier, uint256 _itemPrice)
        public
        onlyOwner
    {
        Item item = new Item(this, _itemPrice, itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._id = _identifier;
        items[itemIndex]._price = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;
        emit SupplyChainStep(
            itemIndex,
            uint256(items[itemIndex]._state),
            address(item)
        );
        itemIndex++;
    }

    function triggerPayment(uint256 _itemIndex) public payable {
        require(items[_itemIndex]._price == msg.value, "only full payments");
        require(
            items[_itemIndex]._state == SupplyChainState.Created,
            "must be created and not payed"
        );
        items[_itemIndex]._state = SupplyChainState.Paid;
        emit SupplyChainStep(
            _itemIndex,
            uint256(items[_itemIndex]._state),
            address(items[_itemIndex]._item)
        );
    }

    function triggerDelivery(uint256 _itemIndex) public onlyOwner {
        require(
            items[_itemIndex]._state == SupplyChainState.Paid,
            "must be paid"
        );
        items[_itemIndex]._state = SupplyChainState.Delivered;
        emit SupplyChainStep(
            _itemIndex,
            uint256(items[_itemIndex]._state),
            address(items[_itemIndex]._item)
        );
    }
}
