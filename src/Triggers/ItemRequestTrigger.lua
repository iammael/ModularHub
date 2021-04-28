-- To Do
local ItemRequestTrigger = {}

function ItemRequestTrigger.init()
    Logger.write("Loading Trigger ItemRequest...")
end

function ItemRequestTrigger.start(username, message)
    if string.find(message, "item") then
        Logger.writeDebug(username .. " is requesting item pipes.")
        -- Inventory.add("pipez:item_pipe", 2)
    end
end

return ItemRequestTrigger
