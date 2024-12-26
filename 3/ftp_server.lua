peripheral.find("modem", rednet.open)

local files = {}

local function saveFile(name, content)
    local file = fs.open(name, "w")
    file.write(content)
    file.close()
end

local function readFile(name)
    if not fs.exists(name) then
        return nil, "arquivo nao existe."
    end
    local file = fs.open(name, "r")
    local content = file.readAll()
    file.close()
    return content
end

print("servidor ftp rodando...")
while true do
    local senderID, message, protocol = rednet.receive()
    local command = message.command
    local name = message.name
    local content = message.content

    if command == "upload" then
        saveFile(name, content)
        rednet.send(senderID, { success = true, message = "arquivo enviado com sucesso." })
    elseif command == "download" then
        local fileContent, err = readFile(name)
        if fileContent then
            rednet.send(senderID, { success = true, content = fileContent })
        else
            rednet.send(senderID, { success = false, message = err })
        end
    else
        rednet.send(senderID, { success = false, message = "comando invalido." })
    end
end
