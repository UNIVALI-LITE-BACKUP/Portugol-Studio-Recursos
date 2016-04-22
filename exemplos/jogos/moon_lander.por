
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
	const inteiro TAXA_DE_ATUALIZACAO = 85



	/* Constantes que definem as telas do jogo */
	const inteiro TELA_SAIR = 0, TELA_MENU = 1, TELA_JOGO = 2, TELA_POUSOU = 3, TELA_QUEBROU = 4, TELA_ESPACO = 5

	/* Variáveis que controlam o fluxo de telas do jogo */
	inteiro tela_atual = TELA_MENU, tela_anterior = TELA_SAIR

		
	/* Variáveis que armazenam a posição dos objetos no jogo */
	inteiro x_foguete = 0, y_foguete = 0, x_plataforma = 350, y_plataforma = 532

	/* Variáveis utilizadas para controlar a velocidade de foguete */
	real velocidade_vertical = 0.0, velocidade_horizontal = 0.0

	logico acelerando = falso
	
	/* Variáveis utilizadas para controlar o FPS e o tempo de jogo */
	inteiro tempo_inicio_jogo = 0

	inteiro tempo_inicio = 0, tempo_decorrido = 0, tempo_restante = 0, tempo_quadro = 1000 / TAXA_DE_ATUALIZACAO
	
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
	inteiro indice_do_fundo_do_cenario = 0, indice_dos_planetas = 0, ultimo_giro_fundo = 0, ultimo_giro_planetas = 0
	
	
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
			iniciar_sincronia_da_taxa_de_atualizacao()
			desenhar_menu()
			finalizar_sincronia_da_taxa_de_atualizacao()

			aguardar_decisao_do_usuario(TELA_JOGO, TELA_SAIR)
		}
	}

	funcao desenhar_menu()
	{
		inteiro y_opcoes = 340
		
		g.definir_fonte_texto("Poetsen One")
		g.definir_tamanho_texto(20.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, falso, falso)

		g.desenhar_imagem(0, 0, imagem_menu)
		
		g.definir_cor(0x333333)
		desenhar_texto_centralizado("Utilize as teclas W, A e D  ou as setas direcionais para jogar", y_opcoes + 225)
		
		g.definir_cor(0xFFFFFF)
		
		desenhar_texto_centralizado("Pressione ENTER para iniciar", y_opcoes + 70)
		desenhar_texto_centralizado("Pressione ESC para sair", y_opcoes + 100)

		g.renderizar()
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
			iniciar_sincronia_da_taxa_de_atualizacao()
			
			atualizar_logica_do_jogo()
			desenhar_tela_jogo()
			
			finalizar_sincronia_da_taxa_de_atualizacao()

			se (t.tecla_pressionada(t.TECLA_ESC))
			{
				ir_para_a_tela(TELA_MENU)
			}
		}
	}

	funcao tela_pousou()
	{
		inteiro tempo_total_de_jogo = u.tempo_decorrido() - tempo_inicio_jogo

		enquanto (tela_atual == TELA_POUSOU)
		{
			iniciar_sincronia_da_taxa_de_atualizacao()
			 
			desenhar_tela_pousou(tempo_total_de_jogo)

			finalizar_sincronia_da_taxa_de_atualizacao()
			
			aguardar_decisao_do_usuario(TELA_JOGO, TELA_MENU)			
		}
	}

	funcao desenhar_tela_pousou(inteiro tempo_total_de_jogo)
	{		
		desenhar_fundo_do_cenario()
		desenhar_planetas()
		desenhar_superficie_lunar()
		desenhar_foguete()
		desenhar_sombra_do_foguete()
		desenhar_texto_tela_pousou(tempo_total_de_jogo)
		desenhar_taxa_de_fps()

		g.renderizar()
	}

	funcao desenhar_texto_tela_pousou(inteiro tempo_total_de_jogo)
	{
		inteiro segundos = tempo_total_de_jogo / 1000
		
		g.definir_fonte_texto("Poetsen One")
		g.definir_tamanho_texto(22.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, falso, falso)
		
		desenhar_texto_centralizado("Parabéns, você venceu!", 240)

		se (segundos > 1)
		{
			desenhar_texto_centralizado("Você pousou em " + segundos  + " segundos!", 270)
		}
		senao
		{
			desenhar_texto_centralizado("Você pousou em 1 segundo!", 270)
		}
		
		desenhar_texto_centralizado("Pressione ENTER para jogar novamente", 300)
		desenhar_texto_centralizado("Pressione ESC para sair", 330)
	}

	funcao tela_quebrou()
	{
		enquanto (tela_atual == TELA_QUEBROU)
		{
			iniciar_sincronia_da_taxa_de_atualizacao()
			
			desenhar_tela_quebrou()
			
			finalizar_sincronia_da_taxa_de_atualizacao()

			aguardar_decisao_do_usuario(TELA_JOGO, TELA_MENU)
		}
	}

	funcao aguardar_decisao_do_usuario(inteiro tela_avancar, inteiro tela_voltar)
	{
		se (t.tecla_pressionada(t.TECLA_ENTER))
		{
			ir_para_a_tela(tela_avancar)
		}
		senao se (t.tecla_pressionada(t.TECLA_ESC))
		{
			ir_para_a_tela(tela_voltar)
		}
	}

	funcao desenhar_tela_quebrou()
	{
		desenhar_fundo_do_cenario()
		desenhar_planetas()
		desenhar_superficie_lunar()
		desenhar_foguete_pegando_fogo()
		desenhar_texto_tela_quebrou()
		desenhar_taxa_de_fps()
		
		g.renderizar()
	}

	funcao desenhar_texto_tela_quebrou()
	{
		g.definir_fonte_texto("Poetsen One")
		g.definir_tamanho_texto(22.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, falso, falso)
       	
       	desenhar_texto_centralizado("Que pena, seu foguete quebrou!", 270)
		desenhar_texto_centralizado("Pressione ENTER para jogar novamente", 300)
		desenhar_texto_centralizado("Pressione ESC para sair", 330)
	}

	funcao desenhar_foguete_pegando_fogo()
	{
		desenhar_foguete_quebrado()
		desenhar_fogo_do_foguete_quebrado()
	}

	funcao desenhar_fogo_do_foguete_quebrado()
	{
		se (tempo_inicio % 150 < 75) // A cada 150 milissegundos, alterna a imagem do fogo
		{
			se (nao alternou_imagem_fogo)
			{
				indice_imagem_fogo = (indice_imagem_fogo + 1) % 6
				alternou_imagem_fogo = verdadeiro
			}
		}
		senao
		{
			alternou_imagem_fogo = falso
		}            	
		
		g.desenhar_porcao_imagem(x_foguete + 20, y_foguete + ALTURA_FOGUETE - 30, indice_imagem_fogo * 30, 0, 30, 45, imagem_fogo)
	}

	funcao desenhar_foguete_quebrado()
	{
		g.desenhar_imagem(x_foguete, y_foguete + ALTURA_FOGUETE - 43, imagem_foguete_quebrado)
	}

	funcao desenhar_foguete()
	{
		g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete)
	}

	funcao tela_espaco()
	{
		enquanto (tela_atual == TELA_ESPACO)
		{
			iniciar_sincronia_da_taxa_de_atualizacao()
			
			desenhar_tela_espaco()

			finalizar_sincronia_da_taxa_de_atualizacao()

			aguardar_decisao_do_usuario()
		}
	}

	funcao desenhar_tela_espaco()
	{
		desenhar_fundo_do_cenario()
		desenhar_planetas()
		desenhar_superficie_lunar()
		desenhar_texto_tela_espaco()
		desenhar_taxa_de_fps()		

		g.renderizar()
	}

	funcao desenhar_texto_tela_espaco()
	{
		g.definir_fonte_texto("Poetsen One")
		g.definir_tamanho_texto(22.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, falso, falso)
   		
       	desenhar_texto_centralizado("Que pena, você se perdeu no espaço!", 270)
		desenhar_texto_centralizado("Pressione ENTER para jogar novamente", 300)
		desenhar_texto_centralizado("Pressione ESC para sair", 330)
	}

	funcao ir_para_a_tela(inteiro nova_tela)
	{
		se (nova_tela != tela_atual)
		{
			tela_anterior = tela_atual
			tela_atual = nova_tela

			se (nova_tela == TELA_MENU)
			{				
				u.aguarde(200)
			}
		}		
	}

	funcao atualizar_logica_do_jogo()
	{
		atualizar_velocidade_vertical()
		atualizar_velocidade_horizontal()
		atualizar_posicao_foguete()
		atualizar_estado_foguete()
	}

	funcao atualizar_velocidade_vertical()
	{
		se (t.tecla_pressionada(t.TECLA_W) ou t.tecla_pressionada(t.TECLA_SETA_ACIMA))
		{
	     	velocidade_vertical = velocidade_vertical - ACELERACAO_FOGUETE

	     	se (velocidade_vertical < -VELOCIDADE_MAXIMA_FOGUETE)
	     	{
				velocidade_vertical = -VELOCIDADE_MAXIMA_FOGUETE
	     	}
	     	
	          acelerando = verdadeiro
	     }
	     senao
	     {
			velocidade_vertical = velocidade_vertical + ACELERACAO_GRAVIDADE

			se (velocidade_vertical > VELOCIDADE_MAXIMA_GRAVIDADE)
			{
				velocidade_vertical = VELOCIDADE_MAXIMA_GRAVIDADE
			}
			
			acelerando = falso
		}
	}

	funcao atualizar_velocidade_horizontal()
	{
		real aceleracao_horizontal = ACELERACAO_FOGUETE * PERCENTUAL_VELOCIDADE_HORIZONTAL
		
		
		se (t.tecla_pressionada(t.TECLA_A) ou t.tecla_pressionada(t.TECLA_SETA_ESQUERDA))
		{
			velocidade_horizontal = velocidade_horizontal - aceleracao_horizontal
		}
		senao se(velocidade_horizontal < 0)
		{
			velocidade_horizontal = velocidade_horizontal + aceleracao_horizontal
		}
		
	
		se (t.tecla_pressionada(t.TECLA_D) ou t.tecla_pressionada(t.TECLA_SETA_DIREITA))
		{
			velocidade_horizontal = velocidade_horizontal + aceleracao_horizontal
		}
		senao se(velocidade_horizontal > 0)
		{
			velocidade_horizontal = velocidade_horizontal - aceleracao_horizontal
		}
	}

	funcao atualizar_posicao_foguete()
	{
		x_foguete = x_foguete + tp.real_para_inteiro(m.arredondar(velocidade_horizontal, 1))
		y_foguete = y_foguete + tp.real_para_inteiro(m.arredondar(velocidade_vertical, 1))
	}

	funcao atualizar_estado_foguete()
	{
		se (x_foguete + LARGURA_FOGUETE < 0 ou x_foguete > LARGURA_TELA ou y_foguete + ALTURA_FOGUETE < 0)
		{
			ir_para_a_tela(TELA_ESPACO)
		}
		senao se (y_foguete + ALTURA_FOGUETE - 10 > y_plataforma)
		{
			se ((x_foguete > x_plataforma) e (x_foguete < x_plataforma + LARGURA_PLATAFORMA - LARGURA_FOGUETE))
            	{
				se (velocidade_vertical <= VELOCIDADE_MAXIMA_POUSO)
				{
					ir_para_a_tela(TELA_POUSOU)
				}
                	senao
                	{
                    	ir_para_a_tela(TELA_QUEBROU)
            		}
            	}
            	senao
            	{
                	se(y_foguete + ALTURA_FOGUETE > tp.real_para_inteiro(ALTURA_TELA - 57 + m.valor_absoluto(400.0-x_foguete+ (LARGURA_FOGUETE / 2))/7))
                	{
                    	ir_para_a_tela(TELA_QUEBROU)
            		}
            	}
		}
	}

	funcao contar_taxa_de_fps()
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

	funcao desenhar_taxa_de_fps()
	{
		g.definir_tamanho_texto(12.0)
		g.definir_cor(0xFFFFFF)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.desenhar_texto(25, 40, "FPS: " + fps)
	}

	funcao desenhar_fundo_do_cenario()
	{				
		se (indice_do_fundo_do_cenario > LARGURA_TELA)
		{
			inteiro delta = LARGURA_TELA - (indice_do_fundo_do_cenario - LARGURA_TELA)
			
			g.desenhar_porcao_imagem(0, 0, indice_do_fundo_do_cenario, 0, delta, ALTURA_TELA, imagem_fundo)
			g.desenhar_porcao_imagem(delta, 0, 0, 0, LARGURA_TELA, ALTURA_TELA, imagem_fundo)
		}
		senao
		{
			g.desenhar_porcao_imagem(0, 0, indice_do_fundo_do_cenario, 0, LARGURA_TELA, ALTURA_TELA, imagem_fundo)
		}
		
		atualizar_indice_do_fundo_do_cenario()
	}

	funcao atualizar_indice_do_fundo_do_cenario()
	{
		se (tempo_inicio - ultimo_giro_fundo > 35)
		{
			indice_do_fundo_do_cenario = (indice_do_fundo_do_cenario + 1) % (LARGURA_TELA * 2)
			ultimo_giro_fundo = tempo_inicio
		}
	}
	
	funcao desenhar_planetas()
	{
		se (indice_dos_planetas > LARGURA_TELA)
		{
			inteiro delta = LARGURA_TELA - (indice_dos_planetas - LARGURA_TELA)
			
			g.desenhar_porcao_imagem(0, 0, indice_dos_planetas, 0, delta, ALTURA_TELA, imagem_planetas)
			g.desenhar_porcao_imagem(delta, 0, 0, 0, LARGURA_TELA, ALTURA_TELA, imagem_planetas)
		}
		senao
		{
			g.desenhar_porcao_imagem(0, 0, indice_dos_planetas, 0, LARGURA_TELA, ALTURA_TELA, imagem_planetas)
		}
		
		atualizar_indice_dos_planetas()	
	}

	funcao atualizar_indice_dos_planetas()
	{
		se (tempo_inicio -ultimo_giro_planetas > 100)
		{
			indice_dos_planetas = (indice_dos_planetas + 1) % (LARGURA_TELA * 2)
			ultimo_giro_planetas = tempo_inicio
		}
	}
	
	funcao desenhar_tela_jogo()
	{		
		desenhar_fundo_do_cenario()
		desenhar_planetas()
		desenhar_superficie_lunar()
        	desenhar_sombra_do_foguete()
		
		se (acelerando)
		{
			
		}

			g.desenhar_imagem(x_foguete, y_foguete, imagem_foguete)
        	

        	desenhar_taxa_de_fps()
		g.renderizar()
	}

	funcao desenhar_jato_do_foguete()
	{
		se (tempo_inicio % 100 < 50) // Alterna a imagem do jato do foguete a cada 100 milisegundos
		{
			g.desenhar_imagem(x_foguete + 10, y_foguete + 66, imagem_jato)
		}
		senao
		{
				g.desenhar_imagem(x_foguete + 10, y_foguete + 66, imagem_jato2)
		}
	}

	funcao desenhar_superficie_lunar()
	{
		g.desenhar_imagem(0, ALTURA_TELA - 84, imagem_lua)
		g.desenhar_imagem(x_plataforma, y_plataforma, imagem_plataforma)
	}

	funcao desenhar_sombra_do_foguete()
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

	funcao iniciar_sincronia_da_taxa_de_atualizacao()
	{
		tempo_inicio = u.tempo_decorrido() + tempo_restante
	}

	funcao finalizar_sincronia_da_taxa_de_atualizacao()
	{
		tempo_decorrido = u.tempo_decorrido() - tempo_inicio
		tempo_restante = tempo_quadro - tempo_decorrido 

		enquanto (TAXA_DE_ATUALIZACAO > 0 e tempo_restante > 0)
		{
			tempo_decorrido = u.tempo_decorrido() - tempo_inicio
			tempo_restante = tempo_quadro - tempo_decorrido
		}

		contar_taxa_de_fps()
	}

	funcao reiniciar_jogo()
	{
		x_foguete = u.sorteia(10, 730)
		y_foguete = 0
		
		acelerando = falso
		
		velocidade_vertical = 0.0
		velocidade_horizontal = 0.0

		tempo_restante = 0		
		tempo_inicio_jogo = u.tempo_decorrido()
		
		frames = 0
		
		// Hack para não exibir o FPS zerado na primeira vez que desenhar a tela
		tempo_inicio_fps = u.tempo_decorrido() - 1002
		
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
 * @POSICAO-CURSOR = 14636; 
 * @DOBRAMENTO-CODIGO = [1, 110, 129, 141, 163, 168, 188, 204, 217, 241, 255, 267, 279, 291, 297, 320, 325, 339, 350, 362, 384, 410, 435, 470, 483, 491, 508, 517, 534, 597, 602, 636, 643, 664, 671, 676, 682];
 * @PONTOS-DE-PARADA = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */