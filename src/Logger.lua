local Logger = {}

function Logger.init(debugMode)
    _debugMode = debugMode
    -- Creating an empty latest log file
    local file = fs.open("logs/latest.log", "w")
    file.close()

    -- Creating an empty timestamped log file
    _currentLogFileName = "logs/" .. os.date("%d-%m-%Y_%H-%M-%S") .. ".log"
    local file = fs.open(_currentLogFileName, "w")
    file.close()

    Logger.writeSuccess("Logger ready!")
end

function Logger.setMonitor(monitor)
    Monitor = monitor
end

function Logger.write(text)
    local text = os.date("[%X] ") .. text

    if monitorPtr then
        -- do monitor stuff
    end

    Logger.writeInFile("logs/latest.log", text)
    Logger.writeInFile(_currentLogFileName, text)
    print(text)
end

function Logger.writeDebug(text)
    if _debugMode then
        Logger.write("[Debug] " .. text)
    end
end

function Logger.writeSuccess(text)
    Logger.write("[Success] " .. text)
end

function Logger.writeWarning(text)
    Logger.write("[Warning] " .. text)
end

function Logger.writeError(text)
    Logger.write("[Error] " .. text)
end

function Logger.writeInFile(filename, text)
    local file = fs.open(filename, "a")
    file.write(text .. "\n")
    file.close()
end

return Logger
