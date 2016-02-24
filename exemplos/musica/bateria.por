programa
{
	inclua biblioteca Util
	inclua biblioteca Sons
	inclua biblioteca Graficos
	inclua biblioteca Teclado
	inclua biblioteca Mouse
	inclua biblioteca Matematica
	inclua biblioteca Tipos

	inteiro LARGURA_DA_TELA = 595

	inteiro andamento = 90 //velocidade da música em BPM (Batidas por Minuto)

	//imagens dos botões
	inteiro botao_ligado = 0
	inteiro botao_desligado = 0
	inteiro botao_ligado_hover = 0 //imagem exibida quando o mouse está em cima de um botão ligado
	inteiro botao_desligado_hover = 0

	//botões de controles gerais
	inteiro botao_mais_rapido = 0 //botão usado para controlar a velocidade da música
	inteiro botao_mais_rapido_hover = 0
	inteiro botao_menos_rapido = 0
	inteiro botao_menos_rapido_hover = 0

	inteiro botao_iniciar = 0
	inteiro botao_iniciar_hover = 0

	inteiro botao_parar = 0
	inteiro botao_parar_hover = 0

	//imagem das lâmpadas
	inteiro lampada_desligada = 0
	inteiro lampada_ligada = 0
	
	inteiro fundo = 0 //imagem de fundo
	inteiro COR_DE_FUNDO_DOS_CONTROLES = 0

	//cores utilizadas na linha divisória horizontal
	inteiro LINHA_COR_ESCURA = 0
	inteiro LINHA_COR_CLARA = 0

	//sons, sem eles a vida não seria a mesma :)
	inteiro som_bumbo = 0
	inteiro som_caixa = 0
	inteiro som_chimbal = 0
	

	inteiro COR_DO_TEXTO = 0

	cadeia FONTE = "Verdana"

	inteiro tempo_atual = 0 //no total existem 16 tempos musicais. Essa variável controla em qual tempo a simulação se encontra no momento.

	//Sempre que você clica em um dos botões para ativar um som uma das posições desse vetor é modificada	
	logico notas[][]   = {
		/* bumbo   */{verdadeiro, falso, falso, falso,  falso, falso, falso, falso, verdadeiro, falso, verdadeiro, falso, falso, falso, falso, falso},
		/* caixa   */{falso, falso, falso, falso,  verdadeiro, falso, falso, falso, falso, falso, falso, falso, verdadeiro, falso, falso, falso},
		/* chimbal */{verdadeiro, falso, verdadeiro, falso,  verdadeiro, falso, verdadeiro, falso, verdadeiro, falso, verdadeiro, falso, verdadeiro, falso, verdadeiro, falso}
	}


	//variáveis usadas para detectar clique do mouse
	inteiro ultimo_x = -1
	inteiro ultimo_y = -1
	logico clicou = falso

	inteiro largura_do_botao = 0
	inteiro altura_do_botao = 0

	logico executando = falso
	
	funcao inicio()
	{
		inicializar()
		executar()
		finalizar()
	}

	funcao executar()
	{
		inteiro tempo_decorrido = 0
		inteiro tempo_inicial = 0
		enquanto (nao Teclado.tecla_pressionada(Teclado.TECLA_ESC))
		{
			tempo_inicial = Util.tempo_decorrido()
			inteiro tempo_semi_colcheia = 60000/andamento/4 //tempo em milisegundos de cada semi-colcheia (um tempo musical dividido em 4 partes)
			desenhar()
			se (tempo_decorrido >= tempo_semi_colcheia)
			{
				se (executando)
				{
					atualizar()
				}
				tempo_decorrido = tempo_decorrido % tempo_semi_colcheia
			}
			
			tratar_cliques()
			tempo_decorrido += Util.tempo_decorrido() - tempo_inicial
		}
	}

	funcao tratar_cliques()
	{
		se (Mouse.algum_botao_pressionado())
		{
			se (ultimo_x <= 0 e ultimo_y <= 0)
			{
				ultimo_x = Mouse.posicao_x()
				ultimo_y = Mouse.posicao_y()
				escreva("Mouse pressionado em X: ", ultimo_x, "\n")
				escreva("Mouse pressionado em Y: ", ultimo_y, "\n")
				escreva("\n")	
			}
		}
		senao
		{
			//verifica se houve clique em algum botão. Se o mouse foi liberado na mesma região em que ele foi pressionao então temos um clique.
			se (ultimo_x >= 0 e ultimo_y >= 0) //se houve um pressionamento do mouse anteriormente...
			{
				inteiro delta_x = Mouse.posicao_x() - ultimo_x
				inteiro delta_y = Mouse.posicao_y() - ultimo_y		
				se (delta_x >= 0 e delta_x <= largura_do_botao e delta_y >= 0 e delta_y <= altura_do_botao)
				{
					clicou = verdadeiro //esta variável será utilizada na função que desenha os botões para verificar se o mouse foi liberado na mesma região onde ele foi pressionado
					escreva("Clique em X: ", Mouse.posicao_x(), "\n")
					escreva("Clique em Y: ", Mouse.posicao_y(), "\n")
					escreva("\n")			
				}
			}
			ultimo_x = -1
			ultimo_y = -1
		}
	}

	funcao atualizar()
	{
		tempo_atual = (tempo_atual + 1) % 16

		//percorre o vetor de notas e gera os sons para as notas que estão ativadas
		para (inteiro linha = 0; linha < 3; linha++) //o número de linhas está pré-fixado de acordo com o número de pelas da bateria (3 peças)
		{
			para (inteiro coluna = 0; coluna < 16; coluna++) //o número de colunas também está prefixado. São 16 subdivisões em um compasso musical.
			{
				se (notas[linha][coluna] e coluna == tempo_atual)
				{
					inteiro som = -1
					se (linha == 0)
						som = som_bumbo
					senao se (linha == 1)
						som = som_caixa
					senao
						som = som_chimbal	
					Sons.reproduzir_som(som, falso)	
				}
			}
		}
	}

	funcao desenhar()
	{
		Graficos.desenhar_imagem(0, 0, fundo)		//desenha fundo

		desenhar_botoes_de_controle()		

		desenha_logo()

		inteiro margem_superior = 100 //os botões de ativação dos sons serão desenhados desse ponto para baixo

		desenhar_linha_divisoria(margem_superior - 10) //linha divisória horizontal
		
		desenhar_linha_divisoria(200)

		escrever_descricao()

		desenhar_nomes_das_pecas(margem_superior) //desenha os nomes Bumbo, Caixa e Chimbal no lado esquerdo da tela

		inteiro margem_esquerda = 100
		inteiro espaco_entre_os_grupos = 10 //espaço entre os grupos de 4 botões
		desenha_botoes(margem_superior, margem_esquerda, espaco_entre_os_grupos) //desenha os botões de ativação dos sons
		desenhar_lampadas(margem_superior - 27, margem_esquerda + 8, espaco_entre_os_grupos)

		Graficos.renderizar()
	}

	funcao desenha_logo()
	{
		real tamanho = 32.0
		inteiro x = 342
		inteiro y = 20
		cadeia texto = "Portugol-909"
		
		Graficos.definir_tamanho_texto(tamanho)
		Graficos.definir_cor(LINHA_COR_ESCURA)
		
		Graficos.desenhar_texto(x+1, y+1, texto)
		
		Graficos.definir_cor(LINHA_COR_CLARA)
		se(executando)
		{
			Graficos.definir_cor(0xffc200)
		}
		Graficos.desenhar_texto(x, y, texto)
	}

	//retorna verdadeiro se o mouse está em cima do botão
	funcao logico desenhar_botao(inteiro x_do_botao, inteiro y_do_botao, inteiro botao_normal, inteiro botao_hover)
	{
		logico hover = mouse_esta_em_cima_do_botao(x_do_botao, y_do_botao)
		se (hover)
			Graficos.desenhar_imagem(x_do_botao, y_do_botao, botao_hover)
		senao
			Graficos.desenhar_imagem(x_do_botao, y_do_botao, botao_normal)
		retorne hover
	}

	funcao logico desenhar_botao_play(inteiro x_do_botao, inteiro y_do_botao, inteiro botao_normal, inteiro botao_hover)
	{
		logico hover=verdadeiro	
		se(nao executando)
		{
			hover = mouse_esta_em_cima_do_botao(x_do_botao, y_do_botao)
		}
		se (hover)
			Graficos.desenhar_imagem(x_do_botao, y_do_botao, botao_hover)
		senao
			Graficos.desenhar_imagem(x_do_botao, y_do_botao, botao_normal)
		retorne hover
	}

	funcao desenhar_botoes_de_controle(){
		
		inteiro margem = 10
		inteiro largura_do_painel = 200
		inteiro espaco_entre_botoes = 3

		inteiro x_do_botao = margem

		logico hover = desenhar_botao_play(x_do_botao, margem, botao_iniciar, botao_iniciar_hover)
		
		se (hover e clicou e nao executando)
		{
			clicou = falso
			iniciar()
		}		

		x_do_botao += espaco_entre_botoes + largura_do_botao
		
		hover = desenhar_botao(x_do_botao, margem, botao_parar, botao_parar_hover)
		se (hover e clicou)
		{
			clicou = falso
			parar()
		}
		
		x_do_botao += espaco_entre_botoes + largura_do_botao


		x_do_botao += 30 //espaço de 30 pixels entre os grupos de botões
		
		//desenha botões de mais e menos e o texto do andamento
		hover = desenhar_botao(x_do_botao, margem, botao_menos_rapido, botao_menos_rapido_hover)
		se (hover e clicou)
		{
			clicou = falso
			diminuir_andamento()
		}
		
		x_do_botao += espaco_entre_botoes + largura_do_botao
		
		hover = desenhar_botao(x_do_botao, margem, botao_mais_rapido, botao_mais_rapido_hover)
		se (hover e clicou)
		{
			clicou = falso
			aumentar_andamento()
		}
		
		x_do_botao += espaco_entre_botoes + largura_do_botao

		Graficos.definir_tamanho_texto(14.0)
		Graficos.desenhar_texto(x_do_botao + 5, margem + 6, Tipos.inteiro_para_cadeia(andamento, 10) + " BPM")
		
	}

	funcao iniciar()
	{
		se (nao executando)
		{
			tempo_atual = 0
			executando = verdadeiro
		}
	}

	funcao parar()
	{
		se (executando)
			executando = falso
	}

	funcao aumentar_andamento()
	{
		se (andamento < 160)
			andamento += 10
	}

	funcao diminuir_andamento()
	{
		se (andamento > 50)
			andamento -= 10
	}

	funcao logico mouse_esta_em_cima_do_botao(inteiro x_do_botao, inteiro y_do_botao)
	{
		//verifica se o mouse está em cima do botão. Assume que os botões tem sempre a mesma largura e altura. 
		inteiro mouse_x = Mouse.posicao_x()
		inteiro mouse_y = Mouse.posicao_y()
		retorne (mouse_x >= x_do_botao e mouse_x <= x_do_botao + largura_do_botao) e (mouse_y >= y_do_botao e mouse_y <= y_do_botao + altura_do_botao)
	}

	funcao desenhar_lampadas(inteiro margem_superior, inteiro margem_esquerda, inteiro gap)
	{
		inteiro x = margem_esquerda
		para (inteiro i=0; i < 16; i++)
		{
			se (i % 4 == 0 e i > 0) //adiciona um espaço a cada grupo de 4 botões
				x += gap

			//decide se desenha a lâmpada ligada ou desligada
			se (i != tempo_atual)							
				Graficos.desenhar_imagem(x, margem_superior, lampada_desligada)
			senao
				Graficos.desenhar_imagem(x, margem_superior, lampada_ligada)
			
			x += largura_do_botao
		}
	}

	funcao desenhar_nomes_das_pecas(inteiro margem_superior)
	{
		cadeia pecas[] = {"Bumbo", "Caixa", "Chimbal"}

		Graficos.definir_tamanho_texto(14.0)
		Graficos.definir_fonte_texto(FONTE)
		Graficos.definir_cor(COR_DO_TEXTO)
		Graficos.definir_estilo_texto(falso, verdadeiro, falso)

		margem_superior += 5

		inteiro margem_esquerda = 15
		inteiro MAX = Util.numero_elementos(pecas)
		para (inteiro i = 0; i < MAX; i++)
		{
			Graficos.desenhar_texto(margem_esquerda, i * altura_do_botao + margem_superior, pecas[i])
		}
	}

	funcao desenhar_linha_divisoria(inteiro y)
	{
		//desenha a linha escura e em seguida desenha uma outra linha clara para da um efeito
		Graficos.definir_cor(LINHA_COR_ESCURA)
		Graficos.desenhar_linha(0, y, LARGURA_DA_TELA, y)

		Graficos.definir_cor(LINHA_COR_CLARA)
		Graficos.desenhar_linha(0, y+1, LARGURA_DA_TELA, y+1)
	}

	funcao escrever_descricao()
	{
		Graficos.definir_tamanho_texto(14.0)
		Graficos.definir_fonte_texto(FONTE)
		Graficos.definir_cor(COR_DO_TEXTO)
		Graficos.definir_estilo_texto(falso, verdadeiro, falso)
		Graficos.desenhar_texto(10, 210, "Os círculos amarelos são batidas ativadas, e cinzas são desativadas.")	
		Graficos.desenhar_texto(10, 230, "Clique em um círculo para ativá-lo ou desativá-lo.")
		Graficos.desenhar_texto(10, 250, "Pode ser feito enquanto está tocando")	
	}

	funcao desenha_botoes(inteiro margem_superior, inteiro margem_esquerda, inteiro gap)
	{
		inteiro y = margem_superior
		para (inteiro linha = 0; linha < 3; linha++)
		{
			inteiro x = margem_esquerda
			para (inteiro coluna = 0; coluna < 16; coluna++)
			{
				se (coluna % 4 == 0 e coluna > 0) //adiciona um espaço a cada grupo de 4 botões
					x += gap

				se (mouse_esta_em_cima_do_botao(x, y))
				{
					//verifica se existe um clique pendente, se existir inverte o estado do botão. Se estava ligado vai ficar desligado, e vice-versa.
					se (clicou)
					{
						notas[linha][coluna] = nao notas[linha][coluna]
						
						//reseta a variável usada para detectar clique
						clicou = falso
					}
					
			   		se (notas[linha][coluna]) //a nota está ativada?
					{
						Graficos.desenhar_imagem(x, y, botao_ligado_hover)
					}
					senao
					{
						Graficos.desenhar_imagem(x, y, botao_desligado_hover)												
					}
				}
				senao
				{
					se (notas[linha][coluna])//a nota está ativada?
					{ 
						se (coluna == tempo_atual e executando)
							Graficos.desenhar_imagem(x, y, botao_ligado_hover)														
						senao
							Graficos.desenhar_imagem(x, y, botao_ligado)
					}
					senao
					{
						Graficos.desenhar_imagem(x, y, botao_desligado)
					}
				}
				x += largura_do_botao
			}
			y += altura_do_botao
		}
	}

	funcao inicializar()
	{
		carregar_imagens()
		carregar_sons()

		LINHA_COR_ESCURA = Graficos.criar_cor(17, 17, 17)
		LINHA_COR_CLARA = Graficos.criar_cor(76, 76, 76)

		COR_DO_TEXTO = Graficos.criar_cor(160, 160, 160)
		COR_DE_FUNDO_DOS_CONTROLES = Graficos.criar_cor(25, 25, 25)

		//inicializando o modo gráfico
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.definir_dimensoes_janela(LARGURA_DA_TELA, 300)
		Graficos.definir_titulo_janela("Bateria Eletrônica")
	}

	funcao carregar_sons()
	{
		//carregando sons...
		cadeia pasta_sons = "./bateria/sons/"

		som_bumbo = Sons.carregar_som(pasta_sons + "bumbo.mp3")
		som_caixa = Sons.carregar_som(pasta_sons + "caixa.mp3")
		som_chimbal = Sons.carregar_som(pasta_sons + "chimbal.mp3")
	}

	funcao carregar_imagens()
	{
		//carregando imagens...
		cadeia pasta_imagens = "./bateria/imagens/"

		fundo = Graficos.carregar_imagem(pasta_imagens + "fundo.jpg")
		botao_ligado = Graficos.carregar_imagem(pasta_imagens + "botao_ligado.png")
		botao_desligado = Graficos.carregar_imagem(pasta_imagens + "botao_desligado.png")
		botao_ligado_hover = Graficos.carregar_imagem(pasta_imagens + "botao_ligado_hover.png")
		botao_desligado_hover = Graficos.carregar_imagem(pasta_imagens + "botao_desligado_hover.png")

		lampada_desligada = Graficos.carregar_imagem(pasta_imagens + "lampada_desligada.png")
		lampada_ligada = Graficos.carregar_imagem(pasta_imagens + "lampada_ligada.png")

		botao_mais_rapido = Graficos.carregar_imagem(pasta_imagens + "mais.png")
		botao_mais_rapido_hover = Graficos.carregar_imagem(pasta_imagens + "mais_hover.png")

		botao_menos_rapido = Graficos.carregar_imagem(pasta_imagens + "menos.png")
		botao_menos_rapido_hover = Graficos.carregar_imagem(pasta_imagens + "menos_hover.png")

		botao_iniciar = Graficos.carregar_imagem(pasta_imagens + "play.png")
		botao_iniciar_hover = Graficos.carregar_imagem(pasta_imagens + "play_hover.png")

		botao_parar = Graficos.carregar_imagem(pasta_imagens + "stop.png")
		botao_parar_hover = Graficos.carregar_imagem(pasta_imagens + "stop_hover.png")

		largura_do_botao = Graficos.largura_imagem(botao_desligado)
		altura_do_botao = Graficos.largura_imagem(botao_desligado)
	}

	funcao finalizar()
	{
		//liberando imagens
		Graficos.liberar_imagem(fundo)
		Graficos.liberar_imagem(botao_ligado)
		Graficos.liberar_imagem(botao_desligado)
		Graficos.liberar_imagem(botao_ligado_hover)
		Graficos.liberar_imagem(botao_desligado_hover)
		Graficos.liberar_imagem(lampada_desligada)
		Graficos.liberar_imagem(lampada_ligada)

		Graficos.liberar_imagem(botao_mais_rapido)
		Graficos.liberar_imagem(botao_mais_rapido_hover)
		Graficos.liberar_imagem(botao_menos_rapido)
		Graficos.liberar_imagem(botao_menos_rapido_hover)
		Graficos.liberar_imagem(botao_iniciar)
		Graficos.liberar_imagem(botao_iniciar_hover)
		Graficos.liberar_imagem(botao_parar)
		Graficos.liberar_imagem(botao_parar_hover)
	
		//liberando sons
		Sons.liberar_som(som_bumbo)
		Sons.liberar_som(som_caixa)
		Sons.liberar_som(som_chimbal)
		
		Graficos.encerrar_modo_grafico()		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 10845; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 */