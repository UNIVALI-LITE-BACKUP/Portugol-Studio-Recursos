
/* CLIQUE NO SINAL DE "+", À ESQUERDA, PARA EXIBIR A DESCRIÇÃO DO EXEMPLO
 *  
 * Copyright (C) 2014 - UNIVALI - Universidade do Vale do Itajaí
 * 
 * Este arquivo de código fonte é livre para utilização, cópia e/ou modificação
 * desde que este cabeçalho, contendo os direitos autorais e a descrição do programa, 
 * seja mantido.
 * 
 * Se tiver dificuldade em compreender este exemplo, acesse as vídeoaulas do Portugol 
 * Studio para auxiliá-lo:
 * 
 * https://www.youtube.com/watch?v=K02TnB3IGnQ&list=PLb9yvNDCid3jQAEbNoPHtPR0SWwmRSM-t
 * 
 * Descrição:
 * 
 * 	Este exemplo é um Jogo escrito em Portugol no qual o jogador controla uma nave que
 * 	deve pousar na lua o mais rápido possível. O exemplo demonstra como utilizar algumas 
 * 	das bibliotecas existentes no Portugol. Neste exemplo, também é possível ver algumas
 * 	técnicas utilizadas na criação de jogos.
 *	
 *	As regras do jogo são as sguintes:
 *	
 *		a) O jogador perde se guiar a nave para fora da tela
 *		b) O jogador perde se pousar a nave fora da plataforma de pouso
 *		c) O jogador perde se pousar a nave muito rápido
 * 	
 *   Jogo adaptado de http://www.gametutorial.net/article/Keyboard-input---Moon-lander
 * 	
 * Autores:
 * 
 * 	Fillipi Domingos Pelz
 *   Luiz Fernando Noschang (noschang@univali.br)
 *   
 * Data: 08/09/2013
 */
 
programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u

	/* Dimensões da tela do jogo */ 
	const inteiro LARGURA_TELA = 800, ALTURA_TELA = 600

	/* Constantes para controle da física do jogo */
	const inteiro ACELERACAO_GRAVIDADE = 1, ACELERACAO_FOGUETE = 1, VELOCIDADE_MAXIMA = 5

	/* Constantes que armazenam as dimensões das imagens utilizadas no jogo */
	const inteiro ALTURA_FOGUETE = 76, LARGURA_FOGUETE = 59, LARGURA_PLATAFORMA = 135

	/* Define quantos quadros serão desenhados por segundo (FPS) */
	const inteiro TAXA_ATUALIZACAO = 25

	/* Variáveis que armazenam a posição dos objetos no jogo */
	inteiro x_foguete = 0, y_foguete = 0, x_plataforma = 350, y_plataforma = 532

	/* Variáveis utilizadas para controlar a velocidade de foguete */
	inteiro velocidade_vertical = 0, velocidade_horizontal = 0

	/* Variáveis utilizadas para controlar o estado do foguete */
	logico acelerando = falso, quebrou = falso, pousou = falso, foi_para_o_espaco = falso


	/* Variáveis utilizadas para controlar o FPS e o tempo de jogo */
	inteiro tempo_inicio_jogo = 0, tempo_total_jogo = 0

	inteiro tempo_inicio = 0, tempo_decorrido = 0, tempo_restante = 0, tempo_quadro = 1000 / TAXA_ATUALIZACAO
	
	
	/* Variáveis que armazenam o endereço de memória das imagens utilizadas no jogo */
	inteiro imagem_fundo = 0, imagem_menu = 0, imagem_borda = 0, imagem_foguete = 0
	
	inteiro imagem_foguete_pousado = 0, imagem_foguete_quebrado = 0, imagem_jato = 0, imagem_plataforma = 0

	
	funcao inicio()
	{
		carregar_imagens()
		inicializar()
		menu()		
		finalizar()
	}

	funcao menu()
	{
		faca 
		{
			g.desenhar_imagem(0, 0, imagem_menu)
			
			g.definir_fonte(g.nome_fonte(), 20.0, 0xFFFFFF, falso, falso, falso)
			g.desenhar_texto(100, 300, "Utilize as teclas W, A e D  ou as setas direcionais para jogar", falso)
			g.desenhar_texto(260, 330, "Pressione ENTER para iniciar", falso)
			g.desenhar_texto(290, 360, "Pressione ESC para sair", falso)

			g.definir_cor(0x000000)
			g.definir_fonte(g.nome_fonte(), 16.0, 0x00FFFF, falso, verdadeiro, falso)
			g.desenhar_texto(0, ALTURA_TELA - 16, " Jogo adaptado de http://www.gametutorial.net/article/Keyboard-input---Moon-lander                     ", verdadeiro)
			g.renderizar()
			
			se (t.tecla_pressionada(t.TECLA_ENTER))
			{
				jogo()
			}
		}
		enquanto (nao t.tecla_pressionada(t.TECLA_ESC))
	}

	funcao jogo()
	{
		reiniciar()

		enquanto (nao t.tecla_pressionada(t.TECLA_ESC))
		{
			tempo_inicio = u.tempo_decorrido()
			
			atualizar()
			desenhar()
			
			tempo_decorrido = u.tempo_decorrido() - tempo_inicio
			tempo_restante = tempo_quadro - tempo_decorrido 

			se (TAXA_ATUALIZACAO > 0  e tempo_restante > 0)
			{
				u.aguarde(tempo_restante)
			}			
		}
	}

	funcao atualizar()
	{
		se (nao pousou e nao quebrou e nao foi_para_o_espaco)
		{
			atualizar_velocidade_vertical()
			atualizar_velocidade_horizontal()
			atualizar_posicao_foguete()
			atualizar_estado_foguete()
		}
		senao
		{	
			se (t.tecla_pressionada(t.TECLA_ENTER))
			{
				reiniciar()
			}
		}
	}

	funcao atualizar_velocidade_vertical()
	{
		se (t.tecla_pressionada(t.TECLA_W) ou t.tecla_pressionada(t.TECLA_SETA_ACIMA))
		{
	     	velocidade_vertical -= ACELERACAO_FOGUETE
	          acelerando = verdadeiro
	     }
	     senao
	     {
			velocidade_vertical += ACELERACAO_GRAVIDADE
			acelerando = falso
		}
	}

	funcao atualizar_velocidade_horizontal()
	{
		se (t.tecla_pressionada(t.TECLA_A) ou t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))
		{
			velocidade_horizontal -= ACELERACAO_FOGUETE
		}
		senao se(velocidade_horizontal < 0)
		{
			velocidade_horizontal += ACELERACAO_GRAVIDADE
		}
	
		se (t.tecla_pressionada(t.TECLA_D) ou t.tecla_pressionada(t.TECLA_SETA_DIREITA))
		{
			velocidade_horizontal += ACELERACAO_FOGUETE
		}
		senao se(velocidade_horizontal > 0)
		{
			velocidade_horizontal -= ACELERACAO_GRAVIDADE
		}
	}

	funcao atualizar_posicao_foguete()
	{
		x_foguete += velocidade_horizontal
		y_foguete += velocidade_vertical
	}

	funcao atualizar_estado_foguete()
	{
		se (x_foguete + LARGURA_FOGUETE < 0 ou x_foguete > LARGURA_TELA ou y_foguete + ALTURA_FOGUETE < 0)
		{
			foi_para_o_espaco = verdadeiro
		}
		senao se (y_foguete + ALTURA_FOGUETE - 10 > y_plataforma)
		{
			se ((x_foguete > x_plataforma) e (x_foguete < x_plataforma + LARGURA_PLATAFORMA - LARGURA_FOGUETE))
            	{
				se (velocidade_vertical <= VELOCIDADE_MAXIMA)
				{
					pousou = verdadeiro
					tempo_total_jogo = u.tempo_decorrido() - tempo_inicio_jogo
				}
                	senao
                	{
                    	quebrou = verdadeiro
            		}
            	}
            	senao
            	{
                	quebrou = verdadeiro
            	}
		}
	}

	funcao desenhar()
	{
		g.desenhar_imagem(0, 0, imagem_fundo)
		g.desenhar_imagem(x_plataforma, y_plataforma, imagem_plataforma)

		se (pousou)
        	{
			g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete_pousado)

			g.definir_fonte(g.nome_fonte(), 20.0, 0xFFFFFF, falso, falso, falso)
			g.desenhar_texto(290, 240, "Parabéns, você venceu!", falso)
			g.desenhar_texto(280, 270, "Você pousou em " + (tempo_total_jogo / 1000) + " segundos!", falso)
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente", falso)
			g.desenhar_texto(290, 330, "Pressione ESC para sair", falso)
		}
		senao se (quebrou)
		{
			g.desenhar_imagem(0, 0, imagem_borda)
            	g.desenhar_imagem(x_foguete, y_foguete + ALTURA_FOGUETE - 43, imagem_foguete_quebrado)
            	g.definir_fonte(g.nome_fonte(), 20.0, 0xFFFFFF, falso, falso, falso)
            	g.desenhar_texto(250, 270, "Que pena, seu foguete quebrou!", falso)
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente", falso)
			g.desenhar_texto(290, 330, "Pressione ESC para sair", falso)
        	}
        	senao se (foi_para_o_espaco)
        	{
        		g.desenhar_imagem(0, 0, imagem_borda)
        		g.definir_fonte(g.nome_fonte(), 20.0, 0xFFFFFF, falso, falso, falso)
            	g.desenhar_texto(230, 270, "Que pena, você se perdeu no espaço!", falso)
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente", falso)
			g.desenhar_texto(290, 330, "Pressione ESC para sair", falso)
        	}
		senao
        	{
			g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete)

			se (acelerando)
			{
				g.desenhar_imagem(x_foguete + 12, y_foguete + 66, imagem_jato)
			}
        	}

		g.definir_cor(0x000000)
		g.definir_fonte(g.nome_fonte(), 16.0, 0x00FFFF, falso, verdadeiro, falso)
		g.desenhar_texto(0, ALTURA_TELA - 16, " Jogo adaptado de http://www.gametutorial.net/article/Keyboard-input---Moon-lander                     ", verdadeiro)
		g.renderizar()
	}

	funcao reiniciar()
	{
		x_foguete = u.sorteia(10, 730)
		y_foguete = 0
		acelerando = falso
		pousou = falso
		quebrou = falso
		foi_para_o_espaco = falso
		velocidade_vertical = 0
		velocidade_horizontal = 0
		tempo_inicio_jogo = u.tempo_decorrido()
		tempo_total_jogo = 0
	}

	funcao carregar_imagens()
	{
		cadeia pasta_imagens = "./moon_lander/"

		imagem_fundo = g.carregar_imagem(pasta_imagens + "fundo.jpg")
		imagem_menu = g.carregar_imagem(pasta_imagens + "menu.jpg")
		imagem_foguete = g.carregar_imagem(pasta_imagens + "foguete.png")
		imagem_jato = g.carregar_imagem(pasta_imagens + "jato_foguete.png")
		imagem_plataforma = g.carregar_imagem(pasta_imagens + "plataforma_pouso.png")
		imagem_borda = g.carregar_imagem(pasta_imagens + "borda.png")
		imagem_foguete_pousado = g.carregar_imagem(pasta_imagens + "foguete_pousado.png")
		imagem_foguete_quebrado = g.carregar_imagem(pasta_imagens + "foguete_quebrado.png")
	}

	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_fundo)
		g.liberar_imagem(imagem_menu)
		g.liberar_imagem(imagem_foguete)
		g.liberar_imagem(imagem_jato)
		g.liberar_imagem(imagem_plataforma)
		g.liberar_imagem(imagem_borda)
		g.liberar_imagem(imagem_foguete_pousado)
		g.liberar_imagem(imagem_foguete_quebrado)
	}

	funcao inicializar()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(800, 600)
		g.definir_titulo_janela("Moon Lander")
	}

	funcao finalizar()
	{
		liberar_imagens()
		g.encerrar_modo_grafico()
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1364; 
 * @DOBRAMENTO-CODIGO = [1, 77, 85, 109, 132, 139, 130, 150, 155, 148, 164, 168, 173, 177, 162, 183, 189, 221, 231, 240, 248, 216, 264, 278, 292, 304, 311];
 */