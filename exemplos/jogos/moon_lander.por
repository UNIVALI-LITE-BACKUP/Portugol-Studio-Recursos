
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
	inclua biblioteca Tipos --> tp
	inclua biblioteca Matematica --> m

	/* Dimensões da tela do jogo */ 
	const inteiro LARGURA_TELA = 800, ALTURA_TELA = 600

	/* Constantes para controle da física do jogo */
	const real ACELERACAO_GRAVIDADE = 0.18, VELOCIDADE_MAXIMA_GRAVIDADE = 4.5
	
	const real ACELERACAO_FOGUETE = 0.20, VELOCIDADE_MAXIMA_FOGUETE = 20.0
	
	const real PERCENTUAL_VELOCIDADE_HORIZONTAL = 1.0, VELOCIDADE_MAXIMA_POUSO = 2.50

	/* Constantes que armazenam as dimensões das imagens utilizadas no jogo */
	const inteiro ALTURA_FOGUETE = 76, LARGURA_FOGUETE = 59, LARGURA_PLATAFORMA = 135

	/* Define quantos quadros serão desenhados por segundo (FPS) */
	const inteiro TAXA_ATUALIZACAO = 85

	

	/* Variáveis que armazenam a posição dos objetos no jogo */
	inteiro x_foguete = 0, y_foguete = 0, x_plataforma = 350, y_plataforma = 532

	/* Variáveis utilizadas para controlar a velocidade de foguete */
	real velocidade_vertical = 0.0, velocidade_horizontal = 0.0
	
	/* Variáveis utilizadas para controlar o estado do foguete */
	logico acelerando = falso, quebrou = falso, pousou = falso, foi_para_o_espaco = falso


	/* Variáveis utilizadas para controlar o FPS e o tempo de jogo */
	inteiro tempo_inicio_jogo = 0, tempo_total_jogo = 0

	inteiro tempo_inicio = 0, tempo_decorrido = 0, tempo_restante = 0, tempo_quadro = 1000 / TAXA_ATUALIZACAO
	
	
	/* Variáveis que armazenam o endereço de memória das imagens utilizadas no jogo */
	inteiro imagem_fundo = 0, imagem_menu = 0, imagem_foguete = 0, imagem_lua=0, imagem_planetas=0
	
	inteiro imagem_jato2 = 0, imagem_foguete_quebrado = 0, imagem_jato = 0, imagem_plataforma = 0, imagem_fogo = 0
	inteiro indice_fogo = 0
	logico atualizou = falso

	inteiro indice_fundo=0, ultimo_giro_fundo=0
	inteiro indice_planetas=0, ultimo_giro_planetas=0
	
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
			
			g.definir_tamanho_texto(20.0)
			g.definir_cor(0xFFFFFF)
			g.definir_estilo_texto(falso, falso, falso)

			cadeia texto[] =
			{
				"Utilize as teclas W, A e D  ou as setas direcionais para jogar",
				"Pressione ENTER para iniciar",
				 "Pressione ESC para sair"
			}
				
			inteiro largura_quadro = g.largura_texto(texto[0]) + 30
			inteiro y_opcoes = 340
			
			g.definir_cor(0x333333)
			g.desenhar_texto((LARGURA_TELA / 2) - g.largura_texto(texto[0]) / 2, y_opcoes + 225, texto[0])
			g.definir_cor(0xFFFFFF)
			g.desenhar_texto((LARGURA_TELA / 2) - g.largura_texto(texto[1]) / 2, y_opcoes + 70, texto[1])
			g.desenhar_texto((LARGURA_TELA / 2) - g.largura_texto(texto[2]) / 2, y_opcoes + 100, texto[2])

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
	funcao desenhar()
	{
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
				se(nao atualizou){
					indice_fogo = (indice_fogo+1)%6
					atualizou = verdadeiro
				}
			}senao{
				atualizou = falso
			}
            	g.desenhar_imagem(x_foguete, y_foguete + ALTURA_FOGUETE - 43, imagem_foguete_quebrado)
            	g.desenhar_porcao_imagem(x_foguete+20, y_foguete + ALTURA_FOGUETE - 30, indice_fogo*30, 0, 30, 45, imagem_fogo)
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

	funcao reiniciar()
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
		tempo_total_jogo = 0
	}

	funcao carregar_imagens()
	{
		cadeia pasta_imagens = "./moon_lander/"

		imagem_lua = g.carregar_imagem(pasta_imagens + "moon.png")
		imagem_fundo = g.carregar_imagem(pasta_imagens + "fundo.jpg")
		imagem_planetas = g.carregar_imagem(pasta_imagens + "planetas.png")
		imagem_menu = g.carregar_imagem(pasta_imagens + "menu.jpg")
		imagem_foguete = g.carregar_imagem(pasta_imagens + "foguete.png")
		imagem_jato = g.carregar_imagem(pasta_imagens + "jato_foguete1.png")
		imagem_plataforma = g.carregar_imagem(pasta_imagens + "plataforma_pouso.png")
		imagem_jato2 = g.carregar_imagem(pasta_imagens + "jato_foguete2.png")
		imagem_foguete_quebrado = g.carregar_imagem(pasta_imagens + "foguete_quebrado.png")
		imagem_fogo = g.carregar_imagem(pasta_imagens + "fogo.png")
	}

	funcao liberar_imagens()
	{
		g.liberar_imagem(imagem_planetas)
		g.liberar_imagem(imagem_lua)
		g.liberar_imagem(imagem_fundo)
		g.liberar_imagem(imagem_menu)
		g.liberar_imagem(imagem_foguete)
		g.liberar_imagem(imagem_jato)
		g.liberar_imagem(imagem_plataforma)
		g.liberar_imagem(imagem_jato2)
		g.liberar_imagem(imagem_foguete_quebrado)
		g.liberar_imagem(imagem_fogo)
	}

	funcao inicializar()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(800, 600)
		g.definir_titulo_janela("Moon Lander")

		carregar_fontes()
	}

	funcao carregar_fontes()
	{
		g.carregar_fonte("./fontes/poetsen_one_regular.ttf")
		g.definir_fonte_texto("Poetsen One")
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
 * @POSICAO-CURSOR = 2624; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {tempo_quadro, 77, 68, 12};
 */