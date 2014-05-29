/**
 * /*${cursor}*/Copyright (C) 2013 - UNIVALI - Universidade do Vale do Itajaí
 * 
 * Este arquivo de código fonte é livre para utilização, cópia e/ou modificação
 * desde que este cabeçalho, contendo os direitos autorais e a descrição do programa, 
 * seja mantido.
 * 
 * Descrição:
 * 
 * 	Este exemplo demonstra a prioridade das operações aritméticas no Portugol. As
 * 	operações de multiplicação (*), divisão (/) e módulo (%) têm prioridade sobre
 * 	as operações de soma (+) e subtração (-). Além disso, o exemplo demonstra como
 * 	os parenteses podem ser utilizados para alterar esta prioridade, fazendo com 
 * 	que uma operação de soma ocorra antes de uma operação de multiplicação.
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
		real a

		// Neste exemplo, a operação de multiplicação (*) será executada primeiro
		a = 5.0 + 4.0 * 2.0
		escreva("5 + 4 * 2 = ", a) 


		// Neste exemplo, a operação de soma (+) será executada primeiro
		a = (5.0 + 4.0) * 2.0
		escreva("\n(5 + 4) * 2 = ", a)		

		/*
		 * Neste exemplo, a operação de divisão (/) será executada primeiro, 
		 * seguida pela operação de multiplicação (*). Por último, será 
		 * executada a operação de soma (+)
		 */
		a = 1.0 + 2.0 / 3.0 * 4.0 
		escreva("\n1 + 2 / 3 * 4 = ", a) // exibe o resultado

		/*
		 * Neste exemplo, a operação de soma (+) será executada primeiro, 
		 * seguida pela operação de multiplicação (*). Por último, será 
		 * executada a operação de divisão (/).
		 */
		a = (1.0 + 2.0) / (3.0 * 4.0)
		escreva("\n(1 + 2) / (3 * 4) = ", a) // exibe o resultado	
	}
}
