
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
 * 	Este exemplo pede o nome do usuário e três valores inteiros, os quais 
 * 	representam a quantidade de porcas, parafusos e arruelas compradas. 
 * 	Após, exibe o nome do usuário seguido da quantidade de cada item comprado
 * 	e o valor total a ser pago.
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
	funcao inicio ()
	{	
		// Os preços dos produtos são definidos em constantes
		
		const real PRECO_PARAFUSO = 1.50
		const real PRECO_ARRUELA  = 2.00
		const real PRECO_PORCA    = 2.50

		cadeia nome
		inteiro quantidadeParafusos, quantidadeArruelas, quantidadePorcas 
		real totalParafusos, totalArruelas, totalPorcas, totalPagar 

		escreva("Digite seu nome: ") 
		leia(nome) 
		
		escreva("\nDigite a quantidade de parafusos que deseja comprar: ") 
		leia(quantidadeParafusos)
		
		escreva("Digite a quantidade de arruelas que deseja comprar: ") 
		leia(quantidadeArruelas)

		escreva("Digite a quantidade de porcas que deseja comprar: ") 
		leia(quantidadePorcas)

		/*
		 * Cálculo dos valores a serem pagos. O cálculo é feito multiplicando
		 * a quantidade de itens vendidos pelo preço de cada item
		 */		
		totalParafusos = PRECO_PARAFUSO * quantidadeParafusos
		totalArruelas = PRECO_ARRUELA * quantidadeArruelas
		totalPorcas = PRECO_PORCA * quantidadePorcas
		
		totalPagar = totalParafusos + totalPorcas + totalArruelas 

		limpa()
		
		escreva("Cliente: ", nome, "\n")
		escreva("===============================\n")
		escreva("Parafusos: ", quantidadeParafusos, "\n")
		escreva("Arruelas: " , quantidadeArruelas, "\n")
		escreva("Porcas: ", quantidadePorcas, "\n")
		escreva("===============================\n")
		escreva("Total a pagar:  R$ ", totalPagar)
	} 
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 815; 
 * @DOBRAMENTO-CODIGO = [1];
 */