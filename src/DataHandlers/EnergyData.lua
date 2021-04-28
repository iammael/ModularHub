local EnergyData = {}

local EnergyTable = {}

function EnergyData.init()
    -- Logger.write("Loading Data Handler Energy...")

    EnergyTable = EnergyData.createDefaultEnergyTable()
end

function EnergyData.get()
    return EnergyTable
end

function EnergyData.createDefaultEnergyTable()
    local t = {
        capacity = 0,
        capacityMax = EnergyController.getEnergyCapacity(),
        fillRatio = 0
    }
    return t
end

function EnergyData.refresh()
    EnergyTable.capacity = EnergyController.getEnergy()
    EnergyTable.fillRatio = EnergyData.getEnergyFillRatio()
end

function EnergyData.getEnergyFillRatio()
    return (EnergyTable.capacity / EnergyTable.capacityMax) * 100
end

return EnergyData
