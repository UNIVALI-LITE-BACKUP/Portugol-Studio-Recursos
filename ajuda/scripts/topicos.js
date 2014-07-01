var topicos = Tree.create
({
    modelType: "children", childrenProperty: "subTopicos",
    data:
    [
        {titulo: "Linguagem Portugol", html: "topicos/linguagem_portugol/index.html", subTopicos:
            [
                {titulo: "Declarações", html: "topicos/linguagem_portugol/declaracoes/index.html", subTopicos:
                    [
                        {titulo: "Declaração de Constante", html: "topicos/linguagem_portugol/declaracoes/constante.html"},
                        {titulo: "Declaração de Função", html: "topicos/linguagem_portugol/declaracoes/funcao.html"},
                        {titulo: "Declaração de Matriz", html: "topicos/linguagem_portugol/declaracoes/matriz.html"},
                        {titulo: "Declaração de Variáveis", html: "topicos/linguagem_portugol/declaracoes/variavel.html"},
                        {titulo: "Declaração de Vetor", html: "topicos/linguagem_portugol/declaracoes/vetor.html"}
                    ]
                },
                {titulo: "Entrada e Saída", html: "topicos/linguagem_portugol/entrada_saida/index.html", subTopicos:[
						{titulo: "Escreva", html: "topicos/linguagem_portugol/entrada_saida/escreva.html"},
						{titulo: "Leia", html: "topicos/linguagem_portugol/entrada_saida/leia.html"},
						{titulo: "Limpa", html: "topicos/linguagem_portugol/entrada_saida/limpa.html"}
				]}
            ]
        }
    ]
});