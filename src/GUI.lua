local GUI = {}

function GUI.init()
    Logger.write("Loading module GUI...")

    PeripheralCount = 0
    -- Logger.setMonitor(monitorPtr)

    Monitor.clear()
    Monitor.setTextColor(colors.white)
    width, height = Monitor.getSize()
    Logger.write("Screen size: " .. width .. "x" .. height)

    GUI.drawTitle("Modular Hub")
    GUI.drawAuthor("iammael")
end

function GUI.drawAll(_itemList, _energyTable)
    local itemList = _itemList or nil
    local energyTable = _energyTable or nil

    GUI.drawFooter()
end

function GUI.addPeripheral(peripheralName, status)
    local y = 4 + PeripheralCount

    Monitor.setCursorPos(1, y)
    Monitor.write(peripheralName .. ":\t")
    Monitor.setTextColor(status and colors.green or colors.red)
    Monitor.write(status and "Connected" or "Disconnected")

    Monitor.setTextColor(colors.white)
    PeripheralCount = PeripheralCount + 1
end

function GUI.drawTitle(title)
    Monitor.setCursorPos((width / 2) - string.len(title) / 2, 1)
    Monitor.write(title)
end

function GUI.drawAuthor(author)
    local text = "By " .. author
    Monitor.setCursorPos((width / 2) - string.len(text) / 2, 2)
    Monitor.setTextColor(colors.cyan)
    Monitor.write(text)
    Monitor.setTextColor(colors.white)
end

function GUI.drawFooter()
    Monitor.setCursorPos(1, height)
    Monitor.write("Last refreshed: " .. os.date("%X"))
end

return GUI
