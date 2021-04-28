local ItemData = {}

local ItemList = {}

function ItemData.init()
    -- Logger.write("Loading Data Handler Item...")

    -- Creates a list of items to display on GUI
    local lines = getLinesFromFile("config/AR_items.txt")
    ItemList = ItemData.createListFromLines(lines)
end

function ItemData.get()
    return ItemList
end

function ItemData.createListFromLines(lines)
    local items = {}

    for i, line in pairs(lines) do
        items[i] = {
            name = line,
            amount = 0
        }
    end
    return items
end

function ItemData.refresh()
    storageItemList = StorageSystem.listItems()[1]

    for i, storageItem in pairs(storageItemList) do
        for index, guiItem in pairs(ItemList) do
            if (guiItem.name == storageItem.name) then
                ItemData.updateAmount(index, storageItem.amount)
            end
        end
    end
end

function ItemData.updateAmount(index, newAmount)
    ItemList[index].amount = newAmount
end

-- IO

function getLinesFromFile(file)
    if not fileExists(file) then
        return {}
    end

    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function fileExists(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

return ItemData
