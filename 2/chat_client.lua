rednet.open("top") 

print("digite o id do servidor:")
local serverID = tonumber(read())

print("digite seu nome de usuario:")
local username = read()

rednet.send(serverID, { type = "register", name = username })

local function listenForMessages()
    while true do
        local _, message = rednet.receive()
        if message.type == "message" or message.type == "notification" then
            print(message.text)
        end
    end
end

local function sendMessage()
    while true do
        local text = read()
        if text == "/sair" then
            rednet.send(serverID, { type = "exit" })
            print("voce saiu do chat.")
            break
        else
            rednet.send(serverID, { type = "message", text = text })
        end
    end
end

parallel.waitForAny(listenForMessages, sendMessage)
