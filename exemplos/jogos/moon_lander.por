
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
 *	As regras do jogo são as seguintes:
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
	inclua biblioteca Tipos --> tp
	inclua biblioteca Matematica --> m

	/* Dimensões da tela do jogo */ 
	const inteiro LARGURA_TELA = 800, ALTURA_TELA = 600

	inteiro centro_da_tela = LARGURA_TELA / 2
	

	/* Constantes para controle da física do jogo */
	const real ACELERACAO_GRAVIDADE = 0.18, VELOCIDADE_MAXIMA_GRAVIDADE = 4.5
	
	const real ACELERACAO_FOGUETE = 0.20, VELOCIDADE_MAXIMA_FOGUETE = 20.0
	
	const real PERCENTUAL_VELOCIDADE_HORIZONTAL = 1.0, VELOCIDADE_MAXIMA_POUSO = 2.50


	/* Constantes que armazenam as dimensões das imagens utilizadas no jogo */
	const inteiro ALTURA_FOGUETE = 76, LARGURA_FOGUETE = 59, LARGURA_PLATAFORMA = 135

	/* Define quantos quadros serão desenhados por segundo (FPS) */
	const inteiro TAXA_ATUALIZACAO = 85



	/* Constantes que definem as telas do jogo */
	const inteiro TELA_SAIR = 0, TELA_MENU = 1, TELA_JOGO = 2, TELA_POUSOU = 3, TELA_QUEBROU = 4, TELA_ESPACO = 5

	/* Variáveis que controlam o fluxo de telas do jogo */
	inteiro tela_atual = TELA_MENU, tela_anterior = TELA_SAIR

		
	/* Variáveis que armazenam a posição dos objetos no jogo */
	inteiro x_foguete = 0, y_foguete = 0, x_plataforma = 350, y_plataforma = 532

	/* Variáveis utilizadas para controlar a velocidade de foguete */
	real velocidade_vertical = 0.0, velocidade_horizontal = 0.0
	
	/* Variáveis utilizadas para controlar o estado do foguete */
	logico acelerando = falso, quebrou = falso, pousou = falso, foi_para_o_espaco = falso


	/* Variáveis utilizadas para controlar o FPS e o tempo de jogo */
	inteiro tempo_inicio_jogo = 0, tempo_total_jogo = 0

	inteiro tempo_inicio = 0, tempo_decorrido = 0, tempo_restante = 0, tempo_quadro = 1000 / TAXA_ATUALIZACAO
	
	inteiro tempo_inicio_fps = 0, tempo_fps = 0, frames = 0, fps = 0
	
	
	/* Variáveis que armazenam o endereço de memória das imagens utilizadas no jogo */
	inteiro imagem_fundo = 0, imagem_menu = 0
	
	inteiro imagem_foguete = 0, imagem_foguete_quebrado = 0
	
	inteiro imagem_lua = 0, imagem_planetas=0
	
	inteiro imagem_jato = 0, imagem_jato2 = 0, imagem_plataforma = 0, imagem_fogo = 0


	/* Variáveis que controlam a animação do fogo quando o foguete quebrou */
	inteiro indice_imagem_fogo = 0
	
	logico alternou_imagem_fogo = falso


	/* Variáveis que controlam a animação das estrelas e dos planetas no fundo do cenário */
	inteiro indice_fundo = 0, indice_planetas = 0, ultimo_giro_fundo = 0, ultimo_giro_planetas = 0
	
	
	funcao inicio()
	{
		inicializar()

		enquanto (tela_atual != TELA_SAIR)
		{
			escolha (tela_atual)
			{
				caso TELA_MENU		: 	tela_menu() 		pare
				caso TELA_JOGO		:	tela_jogo()		pare
				caso TELA_POUSOU	:	tela_pousou()		pare
				caso TELA_QUEBROU	:	tela_quebrou()		pare
				caso TELA_ESPACO	:	tela_espaco()		pare
			}
		}
		
		finalizar()
	}

	funcao tela_menu()
	{
		enquanto (tela_atual == TELA_MENU)
		{
			cadeia texto_menu[] =
			{
				"Utilize as teclas W, A e D  ou as setas direcionais para jogar",
				"Pressione ENTER para iniciar",
				"Pressione ESC para sair"
			}

			inteiro largura_quadro = g.largura_texto(texto_menu[0]) + 30
			inteiro y_opcoes = 340
			
			g.definir_fonte_texto("Poetsen One")
			g.desenhar_imagem(0, 0, imagem_menu)
			
			g.definir_tamanho_texto(20.0)
			g.definir_cor(0xFFFFFF)
			g.definir_estilo_texto(falso, falso, falso)
			
			
			g.definir_cor(0x333333)
			desenhar_texto_centralizado(texto_menu[0], y_opcoes + 225)
			
			g.definir_cor(0xFFFFFF)
			
			desenhar_texto_centralizado(texto_menu[1], y_opcoes + 70)
			desenhar_texto_centralizado(texto_menu[2], y_opcoes + 100)

			g.renderizar()
			
			se (t.tecla_pressionada(t.TECLA_ENTER))
			{
				ir_para_a_tela(TELA_JOGO)
			}
			senao se (t.tecla_pressionada(t.TECLA_ESC))
			{
				ir_para_a_tela(TELA_SAIR)
			}
		}
	}

	funcao desenhar_texto_centralizado(cadeia texto, inteiro y)
	{
		g.desenhar_texto(centro_da_tela - g.largura_texto(texto) / 2, y, texto)
	}

	funcao tela_jogo()
	{
		reiniciar_jogo()
		
		enquanto (tela_atual == TELA_JOGO)
		{
			tempo_inicio = u.tempo_decorrido() + tempo_restante
			
			atualizar_logica_do_jogo()
			desenhar_tela_do_jogo()
			atualizar_fps()			
			sincronizar_taxa_de_atualizacao()

			se (t.tecla_pressionada(t.TECLA_ESC))
			{
				ir_para_a_tela(TELA_MENU)
				u.aguarde(200)
			}
		}
	}

	funcao tela_pousou()
	{
		g.definir_cor(g.COR_AZUL)
		g.limpar()
		g.renderizar()
	}

	funcao tela_quebrou()
	{
		g.definir_cor(g.COR_VERMELHO)
		g.limpar()
		g.renderizar()
	}

	funcao tela_espaco()
	{
		g.definir_cor(g.COR_VERDE)
		g.limpar()
		g.renderizar()
	}

	funcao sincronizar_taxa_de_atualizacao()
	{
		tempo_decorrido = u.tempo_decorrido() - tempo_inicio
		tempo_restante = tempo_quadro - tempo_decorrido 

		enquanto (TAXA_ATUALIZACAO > 0 e tempo_restante > 0 e nao t.tecla_pressionada(t.TECLA_ESC))
		{
			tempo_decorrido = u.tempo_decorrido() - tempo_inicio
			tempo_restante = tempo_quadro - tempo_decorrido
		}
	}

	funcao ir_para_a_tela(inteiro nova_tela)
	{
		se (nova_tela != tela_atual)
		{
			tela_anterior = tela_atual
			tela_atual = nova_tela
		}		
	}

	funcao atualizar_logica_do_jogo()
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
				reiniciar_jogo()
			}
		}
	}

	funcao atualizar_velocidade_vertical()
	{
		se (t.tecla_pressionada(t.TECLA_W) ou t.tecla_pressionada(t.TECLA_SETA_ACIMA))
		{
	     	velocidade_vertical -= ACELERACAO_FOGUETE

	     	se (velocidade_vertical < -VELOCIDADE_MAXIMA_FOGUETE)
	     	{
				velocidade_vertical = -VELOCIDADE_MAXIMA_FOGUETE
	     	}
	     	
	          acelerando = verdadeiro
	     }
	     senao
	     {
			velocidade_vertical += ACELERACAO_GRAVIDADE

			se (velocidade_vertical > VELOCIDADE_MAXIMA_GRAVIDADE)
			{
				velocidade_vertical = VELOCIDADE_MAXIMA_GRAVIDADE
			}
			
			acelerando = falso
		}
	}

	funcao atualizar_velocidade_horizontal()
	{
		se (t.tecla_pressionada(t.TECLA_A) ou t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))
		{
			velocidade_horizontal -= (ACELERACAO_FOGUETE * PERCENTUAL_VELOCIDADE_HORIZONTAL)
		}
		senao se(velocidade_horizontal < 0)
		{
			velocidade_horizontal += (ACELERACAO_GRAVIDADE * PERCENTUAL_VELOCIDADE_HORIZONTAL)
		}
	
		se (t.tecla_pressionada(t.TECLA_D) ou t.tecla_pressionada(t.TECLA_SETA_DIREITA))
		{
			velocidade_horizontal += (ACELERACAO_FOGUETE * PERCENTUAL_VELOCIDADE_HORIZONTAL)
		}
		senao se(velocidade_horizontal > 0)
		{
			velocidade_horizontal -= (ACELERACAO_GRAVIDADE * PERCENTUAL_VELOCIDADE_HORIZONTAL)
		}
	}

	funcao atualizar_posicao_foguete()
	{
		x_foguete += tp.real_para_inteiro(m.arredondar(velocidade_horizontal, 1))
		y_foguete += tp.real_para_inteiro(m.arredondar(velocidade_vertical, 1))
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
				se (velocidade_vertical <= VELOCIDADE_MAXIMA_POUSO)
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
                	se(y_foguete + ALTURA_FOGUETE > tp.real_para_inteiro(ALTURA_TELA - 57 + m.valor_absoluto(400.0-x_foguete+ (LARGURA_FOGUETE / 2))/7))
                	{
                    	quebrou = verdadeiro
            		}
            	}
		}
	}

	funcao atualizar_fps()
	{
		frames = frames + 1
		tempo_fps = u.tempo_decorrido() - tempo_inicio_fps

		se (tempo_fps >= 1000)
		{
			fps = frames
			tempo_inicio_fps = u.tempo_decorrido() - (tempo_fps - 1000)
			frames = 0
		}
	}

	funcao desenhar_fps()
	{
		g.definir_tamanho_texto(12.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.desenhar_texto(25, 40, "FPS: " + fps)
	}


	funcao desenhar_fundo(){
				
		se(indice_fundo>LARGURA_TELA)
		{
			g.desenhar_porcao_imagem(0, 0, indice_fundo, 0, LARGURA_TELA-(indice_fundo-LARGURA_TELA), ALTURA_TELA, imagem_fundo)
			g.desenhar_porcao_imagem(LARGURA_TELA-(indice_fundo-LARGURA_TELA), 0, 0, 0, LARGURA_TELA, ALTURA_TELA, imagem_fundo)
		}
		senao{
			g.desenhar_porcao_imagem(0, 0, indice_fundo, 0, LARGURA_TELA, ALTURA_TELA, imagem_fundo)
		}
		se(tempo_inicio -ultimo_giro_fundo>35){
			indice_fundo= (indice_fundo+1)%(LARGURA_TELA*2)
			ultimo_giro_fundo = tempo_inicio
		}
	}
	funcao desenhar_planetas(){
		

		se(indice_planetas>LARGURA_TELA)
		{
			g.desenhar_porcao_imagem(0, 0, indice_planetas, 0, LARGURA_TELA-(indice_planetas-LARGURA_TELA), ALTURA_TELA, imagem_planetas)
			g.desenhar_porcao_imagem(LARGURA_TELA-(indice_planetas-LARGURA_TELA), 0, 0, 0, LARGURA_TELA, ALTURA_TELA, imagem_planetas)
		}
		senao
		{
			g.desenhar_porcao_imagem(0, 0, indice_planetas, 0, LARGURA_TELA, ALTURA_TELA, imagem_planetas)
		}
		se(tempo_inicio -ultimo_giro_planetas>100){
			indice_planetas= (indice_planetas+1)%(LARGURA_TELA*2)
			ultimo_giro_planetas = tempo_inicio
		}
	}
	funcao desenhar_tela_do_jogo()
	{		
		g.definir_fonte_texto("Poetsen One")
		
		desenhar_fundo()
		desenhar_planetas()
		
		
		g.desenhar_imagem(0, ALTURA_TELA-84, imagem_lua)
		g.desenhar_imagem(x_plataforma, y_plataforma, imagem_plataforma)
		

		se (pousou)
        	{
        		desenhar_sombra_foguete()	
			g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete)

			g.definir_tamanho_texto(22.0)
			g.definir_cor(0xFFFFFF)
			g.definir_estilo_texto(falso, falso, falso)
			
			g.desenhar_texto(290, 240, "Parabéns, você venceu!")
			g.desenhar_texto(280, 270, "Você pousou em " + (tempo_total_jogo / 1000) + " segundos!")
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente")
			g.desenhar_texto(290, 330, "Pressione ESC para sair")
		}
		senao se (quebrou)
		{
			se(tempo_inicio%150 < 75){
				se(nao alternou_imagem_fogo){
					indice_imagem_fogo = (indice_imagem_fogo+1)%6
					alternou_imagem_fogo = verdadeiro
				}
			}senao{
				alternou_imagem_fogo = falso
			}
            	g.desenhar_imagem(x_foguete, y_foguete + ALTURA_FOGUETE - 43, imagem_foguete_quebrado)
            	g.desenhar_porcao_imagem(x_foguete+20, y_foguete + ALTURA_FOGUETE - 30, indice_imagem_fogo*30, 0, 30, 45, imagem_fogo)
			g.definir_tamanho_texto(22.0)
			g.definir_cor(0xFFFFFF)
			g.definir_estilo_texto(falso, falso, falso)
            	
            	g.desenhar_texto(250, 270, "Que pena, seu foguete quebrou!")
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente")
			g.desenhar_texto(290, 330, "Pressione ESC para sair")
        	}
        	senao se (foi_para_o_espaco)
        	{
			g.definir_tamanho_texto(22.0)
			g.definir_cor(0xFFFFFF)
			g.definir_estilo_texto(falso, falso, falso)
        		
            	g.desenhar_texto(230, 270, "Que pena, você se perdeu no espaço!")
			g.desenhar_texto(220, 300, "Pressione ENTER para jogar novamente")
			g.desenhar_texto(290, 330, "Pressione ESC para sair")
        	}
		senao
        	{
        		desenhar_sombra_foguete()
			se (acelerando)
			{
				se(tempo_inicio%100 <50){
					g.desenhar_imagem(x_foguete + 10, y_foguete + 66, imagem_jato)
				}senao{
					g.desenhar_imagem(x_foguete + 10, y_foguete + 66, imagem_jato2)
				}
			}

			g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete)
        	}

        	desenhar_fps()
		g.renderizar()
	}


	funcao desenhar_sombra_foguete()
	{
		inteiro x_centro_foguete = x_foguete + (LARGURA_FOGUETE / 2)
		inteiro distancia_plataforma = (y_foguete + ALTURA_FOGUETE) - y_plataforma - 11
		
		inteiro largura_sombra = LARGURA_FOGUETE + (distancia_plataforma / 10)
		inteiro altura_sombra = largura_sombra / 10

		inteiro x_sombra = x_centro_foguete - (largura_sombra / 2)
		inteiro y_sombra = tp.real_para_inteiro(ALTURA_TELA - 57 + m.valor_absoluto(400.0-x_centro_foguete)/7)
		
		g.definir_cor(g.COR_PRETO)
		g.definir_opacidade(128)
		g.desenhar_elipse(x_sombra, y_sombra, largura_sombra, altura_sombra, verdadeiro)
		g.definir_opacidade(255)
	}

	funcao reiniciar_jogo()
	{
		x_foguete = u.sorteia(10, 730)
		y_foguete = 0
		
		acelerando = falso
		pousou = falso
		quebrou = falso		
		foi_para_o_espaco = falso
		
		velocidade_vertical = 0.0
		velocidade_horizontal = 0.0

		tempo_inicio_jogo = u.tempo_decorrido()
		tempo_inicio_fps = u.tempo_decorrido()
		tempo_total_jogo = 0
	}

	funcao inicializar()
	{
		carregar_imagens()
		carregar_fontes()
		inicializar_janela()		
	}

	funcao carregar_imagens()
	{
		cadeia pasta_imagens = "./moon_lander/"

		imagem_menu = g.carregar_imagem(pasta_imagens + "menu.jpg")
		
		imagem_fundo = g.carregar_imagem(pasta_imagens + "fundo.jpg")
		imagem_planetas = g.carregar_imagem(pasta_imagens + "planetas.png")		

		imagem_lua = g.carregar_imagem(pasta_imagens + "moon.png")
		imagem_plataforma = g.carregar_imagem(pasta_imagens + "plataforma_pouso.png")

		imagem_foguete = g.carregar_imagem(pasta_imagens + "foguete.png")
		imagem_foguete_quebrado = g.carregar_imagem(pasta_imagens + "foguete_quebrado.png")
		
		imagem_jato = g.carregar_imagem(pasta_imagens + "jato_foguete1.png")
		imagem_jato2 = g.carregar_imagem(pasta_imagens + "jato_foguete2.png")
		
		imagem_fogo = g.carregar_imagem(pasta_imagens + "fogo.png")
	}

	funcao inicializar_janela()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(LARGURA_TELA, ALTURA_TELA)
		g.definir_titulo_janela("Moon Lander")
	}

	funcao carregar_fontes()
	{
		g.carregar_fonte("./fontes/poetsen_one_regular.ttf")
	}

	funcao finalizar()
	{
		liberar_imagens()
		g.encerrar_modo_grafico()
	}

	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_menu)

		g.liberar_imagem(imagem_fundo)
		g.liberar_imagem(imagem_planetas)
		
		g.liberar_imagem(imagem_lua)
		g.liberar_imagem(imagem_plataforma)
		
		g.liberar_imagem(imagem_foguete)
		g.liberar_imagem(imagem_foguete_quebrado)

		g.liberar_imagem(imagem_jato)
		g.liberar_imagem(imagem_jato2)
		
		g.liberar_imagem(imagem_fogo)
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5152; 
 * @DOBRAMENTO-CODIGO = [1, 112, 174, 179, 233, 490, 508, 515, 536, 543, 548, 554];
 * @PONTOS-DE-PARADA = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */