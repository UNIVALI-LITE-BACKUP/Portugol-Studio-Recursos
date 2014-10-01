package br.univali.portugol.plugin.exemplo;

import br.univali.portugol.plugin.exemplo.acoes.AcaoPersonalizadaDinamica;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

/**
 *
 * @author Luiz Fernando Noschang
 */
public class PainelImagem extends javax.swing.JPanel
{
    private final PluginExemplo plugin;
    private final AcaoPersonalizadaDinamica acao = new AcaoPersonalizadaDinamica();

    public PainelImagem(final PluginExemplo plugin)
    {
        initComponents();
        this.plugin = plugin;

        checkboxExibir.addItemListener(new ItemListener()
        {
            @Override
            public void itemStateChanged(ItemEvent e)
            {
                if (checkboxExibir.isSelected())
                {
                    plugin.getUtilizador().instalarAcaoPlugin(plugin, acao);
                }
                else
                {
                    plugin.getUtilizador().desinstalarAcaoPlugin(plugin, acao);
                }
            }
        });
        
        
        checkboxAtivar.addItemListener(new ItemListener()
        {
            @Override
            public void itemStateChanged(ItemEvent e)
            {
                acao.setEnabled(checkboxAtivar.isSelected());
            }
        });
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents()
    {

        painelConteudo = new javax.swing.JPanel();
        rotuloDescricao1 = new javax.swing.JLabel();
        checkboxExibir = new javax.swing.JCheckBox();
        checkboxAtivar = new javax.swing.JCheckBox();
        painelBotoes = new javax.swing.JPanel();
        separador = new javax.swing.JSeparator();
        botaoAvancar = new javax.swing.JButton();

        setName("painelImagem"); // NOI18N
        setLayout(new java.awt.BorderLayout());

        rotuloDescricao1.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        rotuloDescricao1.setText("<html>O plugin permite registrar ações na barra de ferramentas do Portugol Studio.<br><br>Uma ação já foi definida por este plugin na inicialização. No entanto, as ações podem ser adicionadas e removidas a qualquer momento.<br><br>Marque a caixa de seleção abaixo para alternar a exibição e o estado de um ação dinâmica.</html>");
        rotuloDescricao1.setVerticalAlignment(javax.swing.SwingConstants.TOP);
        rotuloDescricao1.setBorder(javax.swing.BorderFactory.createEmptyBorder(8, 8, 8, 8));

        checkboxExibir.setText("Exibir ação");
        checkboxExibir.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        checkboxAtivar.setSelected(true);
        checkboxAtivar.setText("Ativar ação");
        checkboxAtivar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        javax.swing.GroupLayout painelConteudoLayout = new javax.swing.GroupLayout(painelConteudo);
        painelConteudo.setLayout(painelConteudoLayout);
        painelConteudoLayout.setHorizontalGroup(
            painelConteudoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(rotuloDescricao1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
            .addGroup(painelConteudoLayout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addComponent(checkboxExibir, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(checkboxAtivar)
                .addGap(0, 77, Short.MAX_VALUE))
        );
        painelConteudoLayout.setVerticalGroup(
            painelConteudoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, painelConteudoLayout.createSequentialGroup()
                .addComponent(rotuloDescricao1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(painelConteudoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(checkboxExibir)
                    .addComponent(checkboxAtivar))
                .addContainerGap(10, Short.MAX_VALUE))
        );

        add(painelConteudo, java.awt.BorderLayout.CENTER);

        painelBotoes.setPreferredSize(new java.awt.Dimension(502, 60));

        botaoAvancar.setText("Voltar");
        botaoAvancar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        botaoAvancar.addActionListener(new java.awt.event.ActionListener()
        {
            public void actionPerformed(java.awt.event.ActionEvent evt)
            {
                botaoAvancarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout painelBotoesLayout = new javax.swing.GroupLayout(painelBotoes);
        painelBotoes.setLayout(painelBotoesLayout);
        painelBotoesLayout.setHorizontalGroup(
            painelBotoesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(painelBotoesLayout.createSequentialGroup()
                .addGap(10, 151, Short.MAX_VALUE)
                .addComponent(botaoAvancar, javax.swing.GroupLayout.PREFERRED_SIZE, 114, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
            .addComponent(separador)
        );
        painelBotoesLayout.setVerticalGroup(
            painelBotoesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, painelBotoesLayout.createSequentialGroup()
                .addComponent(separador, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(botaoAvancar, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        add(painelBotoes, java.awt.BorderLayout.SOUTH);
    }// </editor-fold>//GEN-END:initComponents

    private void botaoAvancarActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_botaoAvancarActionPerformed
    {//GEN-HEADEREND:event_botaoAvancarActionPerformed
        VisaoPluginExemplo visao = (VisaoPluginExemplo) plugin.getVisao();
        visao.exibirPainelInicial();
    }//GEN-LAST:event_botaoAvancarActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botaoAvancar;
    private javax.swing.JCheckBox checkboxAtivar;
    private javax.swing.JCheckBox checkboxExibir;
    private javax.swing.JPanel painelBotoes;
    private javax.swing.JPanel painelConteudo;
    private javax.swing.JLabel rotuloDescricao1;
    private javax.swing.JSeparator separador;
    // End of variables declaration//GEN-END:variables
}
