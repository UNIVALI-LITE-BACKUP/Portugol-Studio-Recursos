var topicos = Tree.create
({
    modelType: "children", childrenProperty: "subTopicos",
    data:
    [
        {titulo: "Linguagem Portugol", html: "topicos/linguagem_portugol/index.html", subTopicos:
            [
                {titulo: "Bibliotecas", html: "topicos/linguagem_portugol/bibliotecas/index.html", subTopicos:[]},
                {titulo: "Declarações", html: "topicos/linguagem_portugol/declaracoes/index.html", subTopicos:
                    [
                        {titulo: "Declaração de Constante", html: "topicos/linguagem_portugol/declaracoes/constante.html"},
                        {titulo: "Declaração de Função", html: "topicos/linguagem_portugol/declaracoes/funcao.html"},
                        {titulo: "Declaração de Matriz", html: "topicos/linguagem_portugol/declaracoes/matriz.html"},
                        {titulo: "Declaração de Variáveis", html: "topicos/linguagem_portugol/declaracoes/variavel.html"},
                        {titulo: "Declaração de Vetor", html: "topicos/linguagem_portugol/declaracoes/vetor.html"}
                    ]
                },
                {titulo: "Entrada e Saída", html: "topicos/linguagem_portugol/entrada_saida/index.html", subTopicos:
					[
						{titulo: "Escreva", html: "topicos/linguagem_portugol/entrada_saida/escreva.html"},
						{titulo: "Leia", html: "topicos/linguagem_portugol/entrada_saida/leia.html"},
						{titulo: "Limpa", html: "topicos/linguagem_portugol/entrada_saida/limpa.html"}
					]
				},
				{titulo: "Estruturas de Controle", html: "topicos/linguagem_portugol/estruturas_controle/index.html", subTopicos:
					[
						{titulo: "Desvios Condicionais", html: "topicos/linguagem_portugol/estruturas_controle/desvio/index.html", subTopicos:
							[
								{titulo: "Se", html: "topicos/linguagem_portugol/estruturas_controle/desvio/se.html"},
								{titulo: "Senao", html: "topicos/linguagem_portugol/estruturas_controle/desvio/se senao.html"},
								{titulo: "Senao se", html: "topicos/linguagem_portugol/estruturas_controle/desvio/se senao se.html"},
								{titulo: "Caso", html: "topicos/linguagem_portugol/estruturas_controle/desvio/Escolha caso.html"}
							]
						},
						{titulo: "Laços de Repetição", html: "topicos/linguagem_portugol/estruturas_controle/repeticao/index.html", subTopicos:
							[
								{titulo: "Enquanto", html: "topicos/linguagem_portugol/estruturas_controle/repeticao/enquanto.html"},
								{titulo: "Faca enquanto", html: "topicos/linguagem_portugol/estruturas_controle/repeticao/enquantofaca.html"},
								{titulo: "Para", html: "topicos/linguagem_portugol/estruturas_controle/repeticao/para.html"}
							]
						}
					]
				},
				{titulo: "Expressões", html: "topicos/linguagem_portugol/expressao/index.html", subTopicos:
					[
					{titulo: "Operações Aritméticas", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/index.html", subTopicos:
								[
						{titulo: "Adição", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/operacao_adicao.html"},
						{titulo: "Subtração", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/operacao_subtracao.html"},
						{titulo: "Multiplicação", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/operacao_multiplicacao.html"},
						{titulo: "Divisão", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/operacao_divisao.html"},
						{titulo: "Modulo", html: "topicos/linguagem_portugol/expressao/operacoes_aritimeticas/operacao_modulo.html"},
								]},
						{titulo: "Operações Relacionais", html: "topicos/linguagem_portugol/expressao/relacional.html"},
						{titulo: "Atribuições", html: "topicos/linguagem_portugol/expressao/atribuicao.html"}
					]
				},
				{titulo: "Tipos", html: "topicos/linguagem_portugol/tipos/index.html", subTopicos:
					[
						{titulo: "Inteiro", html: "topicos/linguagem_portugol/tipos/inteiro.html"},
						{titulo: "Real", html: "topicos/linguagem_portugol/tipos/real.html"},
						{titulo: "Caracter", html: "topicos/linguagem_portugol/tipos/caracter.html"},
						{titulo: "Cadeia", html: "topicos/linguagem_portugol/tipos/cadeia.html"},
						{titulo: "Logico", html: "topicos/linguagem_portugol/tipos/logico.html"},
						{titulo: "Vazio", html: "topicos/linguagem_portugol/tipos/vazio.html"}
					]
				}
            ]
        }
    ]
});