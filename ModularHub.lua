package.path = './lib/?.lua;' .. './src/?.lua;' .. './src/DataHandlers/?.lua;' .. './src/Peripherals/?.lua;' ..
                   './src/Triggers/?.lua;' .. './src/Network/?.lua;' .. package.path

local LIP = require 'LIP'
local Config = LIP.load("config/SmartHub.ini")

Logger = require 'Logger'
GUI = require 'GUI'
AR = require 'AR'
Chat = require 'Chat'
CraftingTrigger = require 'CraftingTrigger'
Inventory = require 'Inventory'
ItemRequestTrigger = require 'ItemRequestTrigger'
ItemData = require 'ItemData'
EnergyData = require 'EnergyData'

local function findPeripherals()
    ArController = peripheral.find("arController")
    ChatBox = peripheral.find("chatBox")
    EnergyController = peripheral.find("mekanism:induction_port")
    EnvironmentDetector = peripheral.find("environmentDetector")
    InventoryManager = peripheral.find("inventoryManager")
    Monitor = peripheral.find("monitor")
    PlayerDetector = peripheral.find("playerDetector")

    -- Storage System
    StorageSystem = peripheral.find("rsBridge")
    if not StorageSystem then
        StorageSystem = peripheral.find("meBridge")
        if not StorageSystem then
            return false
        end
    end
    return true
end

local function init()
    term.clear()

    -- Logger
    Logger.init(Config.Program.Debug)
    Logger.writeDebug("Initialization started.")

    -- Peripherals
    if not findPeripherals() then
        Logger.writeError("Could not find either RS/ME bridge attached. Program ended.")
        return -1
    end

    -- Data
    EnergyData.init()
    ItemData.init()

    -- AR
    AR.init()

    -- Chatbox
    Chat.init()

    -- InventoryManager
    if not Inventory.init() then
        Logger.writeWarning("InventoryManager doesn't have a Memory Card. Related features disabled.")
        InventoryManager = nil
    end

    -- GUI
    GUI.init()
    GUI.addPeripheral("AR Controller", ArController and true or false)
    GUI.addPeripheral("Chat Box", ChatBox and true or false)
    GUI.addPeripheral("Energy Controller", EnergyController and true or false)
    GUI.addPeripheral("Environment Detector", EnvironmentDetector and true or false)
    GUI.addPeripheral("InventoryManager", InventoryManager and true or false)
    GUI.addPeripheral("Player Detector", PlayerDetector and true or false)
    GUI.addPeripheral("Storage System", StorageSystem and true or false)

    -- Triggers
    CraftingTrigger.init()
    ItemRequestTrigger.init()

    Logger.writeDebug("Initialization ended.")
    return 0
end

local function handleMessage(username, message)
    Logger.writeDebug(username .. " just wrote: " .. message)
    if (string.find(message, "get")) then
        Logger.writeDebug("Triggering an ItemRequest for " .. username)
        ItemRequestTrigger.start(username, message)
    end
end

local function scanChat()
    local timeout = os.startTimer(5)
    while true do
        local event = {os.pullEvent()}
        if event[1] == "chat" then
            handleMessage(event[2], event[3])
            break
        elseif event[1] == "timer" and event[2] == timeout then
            break
        end
    end
end

local function routine()
    -- Data
    ItemData.refresh()
    EnergyData.refresh()

    -- GUI
    GUI.drawAll()

    -- Event handling
    scanChat()

    -- AR
    AR.drawAll(ItemData.get(), EnergyData.get())
end

local function main()
    if init() == -1 then
        return
    end

    local i = 1
    while true do
        Logger.writeDebug("Routine # " .. i .. " started.")
        routine()
        Logger.writeDebug("Routine # " .. i .. " ended.")
        i = i + 1
    end
end

main()

return
