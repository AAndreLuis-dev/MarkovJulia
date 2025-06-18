# Cadeia de Markov com Julia: Análise de Migração Populacional

![Linguagem](https://img.shields.io/badge/Linguagem-Julia-9558B2?style=for-the-badge)
![Licença](https://img.shields.io/badge/Licença-MIT-green?style=for-the-badge)

## 📜 Descrição

Este projeto acadêmico, desenvolvido para a disciplina de Estruturas Matemáticas, utiliza uma **Cadeia de Markov** para modelar e prever a dinâmica de migração populacional em uma cidade fictícia chamada Terraviva. A implementação dos cálculos foi feita utilizando a linguagem de programação **Julia**, conhecida por sua alta performance em computação científica.

O objetivo é analisar como a população, distribuída entre as regiões **Centro, Subúrbio e Zona Rural**, evolui ao longo dos anos e determinar qual será a distribuição de equilíbrio a longo prazo (vetor estacionário).

## 🎲 O Modelo Matemático

O problema é modelado com os seguintes parâmetros:

### Distribuição Inicial da População ($X_0$)

A população total de 1.000.000 de habitantes está inicialmente distribuída da seguinte forma:
-   **Centro:** 500.000 (50%)
-   **Subúrbio:** 300.000 (30%)
-   **Rural:** 200.000 (20%)

O vetor de estado inicial é:
$$
X_0 = \begin{bmatrix} 0.5 \\ 0.3 \\ 0.2 \end{bmatrix}
$$

### Matriz de Transição ($M$)

As probabilidades anuais de um morador se mudar de uma região para outra são representadas pela seguinte matriz de transição (colunas representam a **origem** e linhas o **destino**):

$$
M = \begin{bmatrix}
0.80 & 0.20 & 0.10 \\
0.15 & 0.60 & 0.30 \\
0.05 & 0.20 & 0.60
\end{bmatrix}
$$

## 🛠️ Tecnologias Utilizadas

-   **Julia:** Linguagem de programação principal para a execução dos cálculos matriciais.
-   **LaTeX:** Utilizado para a documentação formal do trabalho acadêmico.

## 🚀 Como Executar o Projeto

Para executar a simulação e obter os resultados, siga os passos abaixo.

### Pré-requisitos

-   [Julia](https://julialang.org/downloads/) (versão 1.x ou superior)
-   [Git](https://git-scm.com/downloads)

### Instalação e Execução

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/AAndreLuis-dev/MarkovJulia.git](https://github.com/AAndreLuis-dev/MarkovJulia.git)
    ```

2.  **Navegue até o diretório do projeto:**
    ```bash
    cd MarkovJulia
    ```

3.  **Execute o script Julia:**
    ```bash
    julia index.jl
    ```

### Saída Esperada

Ao executar o script, o console exibirá:
-   A matriz de transição e o vetor de estado inicial.
-   A distribuição populacional para os próximos 4 anos.
-   O vetor estacionário, que representa a distribuição de equilíbrio da população a longo prazo.

## 👥 Equipe

Este projeto foi desenvolvido por:

-   [André Luis Almeida Alves](https://github.com/AAndreLuis-dev)
-   João Vitor Santos Santana
-   Isabelle Maciel dos Santos

