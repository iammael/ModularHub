local Inventory = {}

function Inventory.init()
    Logger.write("Loading module Inventory...")

    if not InventoryManager.getOwner() then
        return false
    end
    return true
end

function Inventory.add()
    --
end

return Inventory
