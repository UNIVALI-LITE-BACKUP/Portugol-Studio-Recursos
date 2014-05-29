// O exemplo a seguir pede ao usuário dois valores e exibe a soma.
programa
{
	funcao inicio()
	{
		real a, b, soma, sub, mult, div
		
		escreva("Digite um número inteiro: ")
		leia(a) // lê o primeiro valor digitado pelo usuário e armazena na variável a

		escreva("Digite outro número inteiro: ")
		leia(b) // lê o segundo valor digitado pelo usuário e armazena na variável b

		soma = a + b // soma os dois valores
		sub  = a - b // subtrai os dois valores
		mult = a * b // multiplica os dois valores
		div  = a / b // divide os dois valores
		
		escreva("\nA soma dos números é igual a: ", soma) // exibe o resultado/*${cursor}*/
		escreva("\nA subtração dos números é igual a: ", sub) // exibe o resultado
		escreva("\nA multiplicação dos números é igual a: ", mult) // exibe o resultado
		escreva("\nA divisão dos números é igual a: ", div) // exibe o resultado
	
	}
}
