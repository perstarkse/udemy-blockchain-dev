const itemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", async accounts => {
    it(".... should be able to add an item", async function () {
        const itemManagerInstance = await itemManager.deployed();
        const itemName = "testone";
        const itemPrice = "500";

        let result = await itemManagerInstance.createItem(itemName, itemPrice, { from: accounts[0] });
        console.log(result);
        assert.equal(result.logs[0].args._itemIndex, 0, "its not the first item");

        const item = await itemManagerInstance.items(0);
        assert.equal(item._id, itemName, "not the same item");
    })
})
