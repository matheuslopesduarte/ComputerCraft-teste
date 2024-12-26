rednet.open("top") 

local function uploadFile(serverID, filePath)
    if not fs.exists(filePath) then
        print("arquivo nao existe.")
        return
    end

    local file = fs.open(filePath, "r")
    local content = file.readAll()
    file.close()

    rednet.send(serverID, { command = "upload", name = fs.getName(filePath), content = content })
    local _, response = rednet.receive()
    if response.success then
        print(response.message)
    else
        print("erro:", response.message)
    end
end

local function downloadFile(serverID, fileName, savePath)
    rednet.send(serverID, { command = "download", name = fileName })
    local _, response = rednet.receive()
    if response.success then
        local file = fs.open(savePath, "w")
        file.write(response.content)
        file.close()
        print("arquivo baixado e salvo como " .. savePath)
    else
        print("erro:", response.message)
    end
end

print("cliente ftp")
print("digite o id do servidor:")
local serverID = tonumber(read())

while true do
    print("escolha uma opcao:")
    print("1. enviar arquivo")
    print("2. baixar arquivo")
    print("3. sair")
    local choice = read()

    if choice == "1" then
        print("digite o caminho do arquivo para enviar:")
        local filePath = read()
        uploadFile(serverID, filePath)
    elseif choice == "2" then
        print("digite o nome do arquivo para baixar:")
        local fileName = read()
        print("digite o caminho para salvar:")
        local savePath = read()
        downloadFile(serverID, fileName, savePath)
    elseif choice == "3" then
        break
    else
        print("opcao invalida.")
    end
end
