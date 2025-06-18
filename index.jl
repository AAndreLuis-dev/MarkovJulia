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
    # Verificar se a soma é próxima de 1
    if abs(sum(vetor) - 1.0) > 1e-6
        println("Atenção: A soma dos valores do vetor inicial não é exatamente 1. Ajustando para somar 1.")
        vetor = vetor ./ sum(vetor)
    end
    return vetor
end

function formatarVetor(vetor; populacao_total=nothing)
    percentagens_str = join([@sprintf("%6.2f%%", x * 100) for x in vetor], "  ")
    
    if populacao_total !== nothing
        populacao_abs_str = join([@sprintf("%d", round(x * populacao_total)) for x in vetor], "  ")
        return "$(percentagens_str)  (População: $(populacao_abs_str))"
    else
        return percentagens_str
    end
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

    print("Informe a população total da cidade (ex: 1000000): ")
    populacao_total = parse(Int, readline())

    matrizTransicao = lerMatrizTransicao(tamanho)
    vetorEstado = lerVetorEstadoInicial(tamanho)

    println("\n✅ Matriz de Transição:")
    for i in 1:tamanho
        println(join([@sprintf("%8.2f", matrizTransicao[i, j]) for j in 1:tamanho], "  "))
    end

    println("\n✅ Vetor de Estado Inicial (Passo 0):")
    println(formatarVetor(vetorEstado, populacao_total=populacao_total))

    for passo in 1:passos
        vetorEstado = matrizTransicao * vetorEstado
        println("\n🔁 Passo $passo:")
        println(formatarVetor(vetorEstado, populacao_total=populacao_total))
    end

    vetorEstacionario, passosConvergencia = encontrarDistribuicaoEstacionariaIterativamente(matrizTransicao)
    println("\n♾️ Distribuição Estacionária (convergência em $passosConvergencia passos):")
    println(formatarVetor(vetorEstacionario, populacao_total=populacao_total))

    println("\nExemplo de aplicação para a cidade de Terraviva:")
    terraviva_matriz = [
        0.80 0.20 0.10;
        0.15 0.60 0.30;
        0.05 0.20 0.60
    ]
    terraviva_inicial = [0.5; 0.3; 0.2]
    terraviva_populacao_total = 1_000_000

    println("\nMatriz de Transição de Terraviva:")
    for i in 1:3
        println(join([@sprintf("%8.2f", terraviva_matriz[i, j]) for j in 1:3], "  "))
    end

    println("\nVetor de Estado Inicial de Terraviva:")
    println(formatarVetor(terraviva_inicial, populacao_total=terraviva_populacao_total))

    for ano in 1:4
        terraviva_inicial = terraviva_matriz * terraviva_inicial
        println("\nPopulação de Terraviva após Ano $ano:")
        println(formatarVetor(terraviva_inicial, populacao_total=terraviva_populacao_total))
    end

    terraviva_estacionario, _ = encontrarDistribuicaoEstacionariaIterativamente(terraviva_matriz)
    println("\nDistribuição Estacionária de Terraviva:")
    println(formatarVetor(terraviva_estacionario, populacao_total=terraviva_populacao_total))
end

main()