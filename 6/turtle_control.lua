peripheral.find("modem", rednet.open)

print("controle remoto da tartaruga")
print("qual o id da tartaruga?")

local idTartaruga = tonumber(read())

local function enviarComando(comando)
    rednet.send(idTartaruga, { comando = comando })
    local _, resposta = rednet.receive()
    print(resposta.mensagem)
end

while true do
    print("\ncomandos disponiveis:")
    print("1. andar pra frente")
    print("2. andar pra tras")
    print("3. subir")
    print("4. descer")
    print("5. virar pra esquerda")
    print("6. virar pra direita")
    print("7. cavar")
    print("8. colocar bloco")
    print("9. sair")

    local escolha = read()

    -- essa bosta não tem switch case

    if escolha == "1" then
        enviarComando("frente")
    elseif escolha == "2" then
        enviarComando("tras")
    elseif escolha == "3" then
        enviarComando("cima")
    elseif escolha == "4" then
        enviarComando("baixo")
    elseif escolha == "5" then
        enviarComando("esquerda")
    elseif escolha == "6" then
        enviarComando("direita")
    elseif escolha == "7" then
        enviarComando("cavar")
    elseif escolha == "8" then
        enviarComando("colocar")
    elseif escolha == "9" then
        print("desligando o controle remoto...")
        break
    else
        print("opcao invalida")
    end
end
