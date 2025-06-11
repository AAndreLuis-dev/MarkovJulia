using LinearAlgebra, Printf

function lerMatrizTransicao(tamanho)
    matriz = zeros(tamanho, tamanho)
    println("Digite os valores da matriz de transição (por COLUNAS):")
    for j in 1:tamanho
        for i in 1:tamanho
            print("P[$i,$j] (prob. de ir para estado $i se estiver no estado $j): ")
            matriz[i, j] = parse(Float64, readline())
        end
    end
    return matriz
end

function lerVetorEstadoInicial(tamanho)
    vetor = zeros(tamanho)
    println("\nDigite os valores do vetor de estado inicial (valores devem somar 1):")
    for i in 1:tamanho
        print("x[$i]: ")
        vetor[i] = parse(Float64, readline())
    end
    return vetor
end

function formatarVetor(vetor)
    return join([@sprintf("%6.2f%%", x * 100) for x in vetor], "  ")
end

function encontrarDistribuicaoEstacionariaIterativamente(matrizTransicao; tolerancia=1e-8, maxIter=1000)
    n = size(matrizTransicao, 1)
    estado = fill(1.0 / n, n)  # Estado inicial uniforme
    for passo in 1:maxIter
        novoEstado = matrizTransicao * estado
        if norm(novoEstado - estado, Inf) < tolerancia
            return novoEstado, passo
        end
        estado = novoEstado
    end
    error("Não convergiu após $maxIter iterações")
end

function main()
    println("=== Cadeia de Markov Genérica ===")
    print("Informe o tamanho da matriz de transição (ex: 2, 3, 4): ")
    tamanho = parse(Int, readline())

    print("Informe quantos passos deseja visualizar: ")
    passos = parse(Int, readline())

    matrizTransicao = lerMatrizTransicao(tamanho)
    vetorEstado = lerVetorEstadoInicial(tamanho)

    println("\n✅ Matriz de Transição:")
    for i in 1:tamanho
        println(join([@sprintf("%8.2f", matrizTransicao[i, j]) for j in 1:tamanho], "  "))
    end

    println("\n✅ Vetor de Estado Inicial (Passo 0):")
    println(formatarVetor(vetorEstado))

    for passo in 1:passos
        vetorEstado = matrizTransicao * vetorEstado
        println("🔁 Passo $passo:")
        println(formatarVetor(vetorEstado))
    end

    vetorEstacionario, passosConvergencia = encontrarDistribuicaoEstacionariaIterativamente(matrizTransicao)
    println("\n♾️ Distribuição Estacionária (convergência em $passosConvergencia passos):")
    println(formatarVetor(vetorEstacionario))
end

main()
