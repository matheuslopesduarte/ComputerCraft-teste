peripheral.find("modem", rednet.open)

print("servidor da turtle rodando... aguardando comandos")


while true do
    local idEnviador, mensagem = rednet.receive()

    -- essa bosta não tem switch case

    if mensagem.comando == "frente" then
        local sucesso = turtle.forward()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "foi pra frente" or "nao conseguiu ir pra frente" })
    elseif mensagem.comando == "tras" then
        local sucesso = turtle.back()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "foi pra tras" or "nao conseguiu ir pra tras" })
    elseif mensagem.comando == "cima" then
        local sucesso = turtle.up()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "subiu" or "nao conseguiu subir" })
    elseif mensagem.comando == "baixo" then
        local sucesso = turtle.down()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "desceu" or "nao conseguiu descer" })
    elseif mensagem.comando == "esquerda" then
        turtle.turnLeft()
        rednet.send(idEnviador, { sucesso = true, mensagem = "virou pra esquerda" })
    elseif mensagem.comando == "direita" then
        turtle.turnRight()
        rednet.send(idEnviador, { sucesso = true, mensagem = "virou pra direita" })
    elseif mensagem.comando == "cavar" then
        local sucesso = turtle.dig()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "cavou o bloco" or "nao conseguiu cavar" })
    elseif mensagem.comando == "colocar" then
        local sucesso = turtle.place()
        rednet.send(idEnviador, { sucesso = sucesso, mensagem = sucesso and "colocou o bloco" or "nao conseguiu colocar o bloco" })
    else
        rednet.send(idEnviador, { sucesso = false, mensagem = "comando desconhecido" })
    end
end