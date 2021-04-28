local Inventory = {}

function Inventory.init()
    Logger.write("Loading module Inventory...")

    if not InventoryManager.getOwner() then
        return false
    end

    _inputDirection = "south" -- static
    return true
end

function Inventory.add(itemName, amount)
    return InventoryManager.addItemToPlayer(_inputDirection, amount, itemName)
end

return Inventory
