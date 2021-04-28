local AR = {}

function AR.init()
    Logger.write("Loading module AR...")

    ArController.clear()
    ArController.setRelativeMode(true, 1600, 900)
    -- ArController.drawString("AR loading...", 800, 450, 0xffffff)
end

function AR.drawAll(itemList, energyTable)
    ArController.clear()

    AR.drawEnergyTable(energyTable)
    AR.drawItemList(itemList)
end

function AR.drawEnergyTable(energyTable)
    local start_x = 0
    local step_x = 50
    local padding_x = 10

    local start_y = 810
    local padding_y = 0

    local x = start_x
    local y = start_y

    -- Icon
    local item_icon = "mekanism:basic_energy_cube"
    ArController.drawItemIcon(item_icon, x + padding_x, y + padding_y)

    -- Text
    local text = tostring(energyTable.capacity) .. "/" .. tostring(energyTable.capacityMax) .. " (" ..
                     tostring(energyTable.fillRatio) .. "%)"
    ArController.drawString(text, x + padding_x + 35, y + 10, 0xffffff)
end

function AR.drawItemList(itemList)
    -- ArController.fill(0, 855, 620, 900, 0x31322f)

    local start_x = 0
    local step_x = 50
    local padding_x = 10

    local start_y = 860
    local padding_y = 0

    local x = start_x
    local y = start_y

    for i, item in pairs(itemList) do
        -- Icon
        local item_icon = item.name
        ArController.drawItemIcon(item_icon, x + padding_x, y + padding_y)

        -- Text
        local amount_text = tostring(item.amount)
        local text_size = getTextSize(amount_text)
        ArController.drawString(amount_text, x + padding_x + 35, y + 10, 0xffffff)
        x = x + text_size + step_x
    end
end

function getTextSize(txt)
    local char_size = 10
    return string.len(txt) * char_size
end

return AR
