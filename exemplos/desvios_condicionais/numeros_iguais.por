
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
 * 	Este exemplo pede ao usuário que informe um valor de 0 a 6. Logo após, o programa
 * 	sorteia um valor também de 0 a 6 e exibe uma mensagem informando se o número sorteado
 * 	e o número digitado são iguais.
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
	inclua biblioteca Util --> util
	
	funcao inicio()
	{
		inteiro num_digitado, num_sorteado

		escreva("Informe um número de 0 a 6: ")
		leia(num_digitado)

		num_sorteado = util.sorteia(0, 6)
		
		se (num_digitado == num_sorteado) // verifica se o valor sorteado é igual ao valor digitado pelo usuário 
		{
			escreva("Os números são iguais")
		}
		senao
		{
			escreva("Os números são diferentes")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 782; 
 * @DOBRAMENTO-CODIGO = [1];
 */