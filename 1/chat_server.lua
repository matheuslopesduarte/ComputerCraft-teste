peripheral.find("modem", rednet.open)

local users = {}

print("servidor de chat rodando...")
while true do
    
    local senderID, message, protocol = rednet.receive()

    if message.type == "register" then
        users[senderID] = message.name
        print(message.name .. " entrou no chat.")

        for id, _ in pairs(users) do
            if id ~= senderID then
                rednet.send(id, { type = "notification", text = message.name .. " entrou no chat." })
            end  
        end
        
    elseif message.type == "message" then
        local senderName = users[senderID] or "desconhecido"
        local chatMessage = senderName .. ": " .. message.text
        print(chatMessage)

        for id, _ in pairs(users) do
            if id ~= senderID then
                rednet.send(id, { type = "message", text = chatMessage })
            end
        end

    elseif message.type == "exit" then
        local name = users[senderID] or "desconhecido"
        users[senderID] = nil
        print(name .. " saiu do chat.")

        for id, _ in pairs(users) do
            rednet.send(id, { type = "notification", text = name .. " saiu do chat." })
        end

    end
    
end
