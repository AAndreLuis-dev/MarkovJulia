using LinearAlgebra

function main()
    # Estado inicial: 60% no centro, 40% no subúrbio
    estadoInicial = [0.60, 0.40]

    # Matriz de transição da população
    matrizTransicao = [
        0.95 0.03;
        0.05 0.97
    ]

    println("📆 Previsão de população (Centro/Subúrbio):")
    estadoAtual = estadoInicial
    for ano in 1:4
        estadoAtual = matrizTransicao * estadoAtual
        println("Ano $ano:")
        println("  Centro 🏙️: ", round(estadoAtual[1] * 100, digits=2), "%")
        println("  Subúrbio 🏘️: ", round(estadoAtual[2] * 100, digits=2), "%")
    end

    println()

    # Vetor estacionário
    autovalores, autovetores = eigen(transpose(matrizTransicao))
    indiceEstavel = findfirst(x -> isapprox(x, 1.0; atol=1e-8), autovalores)
    vetorEstavel = autovetores[:, indiceEstavel]
    vetorEstavel = vetorEstavel / sum(vetorEstavel)

    println("♾️ Distribuição estacionária (população no longo prazo):")
    println("Centro 🏙️: ", round(vetorEstavel[1] * 100, digits=2), "%")
    println("Subúrbio 🏘️: ", round(vetorEstavel[2] * 100, digits=2), "%")
end

main()  # executa a função
