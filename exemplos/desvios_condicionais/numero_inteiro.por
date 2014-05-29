
/* CLIQUE NO SINAL DE "+", À ESQUERDA, PARA EXIBIR A DESCRIÇÃO DO EXEMPLO
 *  
 * Copyright (C) 2013 - UNIVALI - Universidade do Vale do Itajaí
 * 
 * Este arquivo de código fonte é livre para utilização, cópia e/ou modificação
 * desde que este cabeçalho, contendo os direitos autorais e a descrição do programa, 
 * seja mantido.
 * 
 * Descrição:
 * 
 * 	Este exemplo pede ao usuário que informe um número inteiro. Logo após, exibe uma
 * 	mensagem indicando se o número informado é positivo, negativo ou igual a zero.
 * 
 * Autores:
 * 
 * 	Giordana Maria da Costa Valle
 * 	Carlos Alexandre Krueger
 * 	
 * Data: 01/06/2013
 */

programa
{
	funcao inicio()
	{
		inteiro num
		
		escreva("Digite um número inteiro: ")
		leia(num)

		se(num > 0) // Verifica se o número é positivo
		{ 
			escreva("O número é positivo")
		}
		senao se(num < 0) // Verifica se o número é negativo
		{ 
			escreva("O número é negativo")
		}
		senao // Se não é positivo nem negativo, só pode ser igual a zero 
		{
			escreva("O número é igual zero")
		}

		escreva("\n")		
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 680; 
 * @DOBRAMENTO-CODIGO = [1];
 */