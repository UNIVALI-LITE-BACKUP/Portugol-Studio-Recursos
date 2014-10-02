package br.univali.portugol.plugin.exemplo;

/**
 *
 * @author Luiz Fernando Noschang
 */
public class PainelInicial extends javax.swing.JPanel
{
    private final JanelaCdigoFonte janelaCdigoFonte = new JanelaCdigoFonte();
    private final PluginExemplo plugin;
    private final PainelFlutuante painelFlutuante;

    public PainelInicial(PluginExemplo plugin)
    {
        initComponents();
        this.plugin = plugin;
        this.painelFlutuante = new PainelFlutuante(plugin, this);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        rotuloDescricao = new javax.swing.JLabel();
        painelCentro = new javax.swing.JPanel();
        botaoPainelFlutuante = new javax.swing.JToggleButton();
        painelBotoes = new javax.swing.JPanel();
        separador = new javax.swing.JSeparator();
        botaoAvancar = new javax.swing.JButton();
        botaoTestar = new javax.swing.JButton();

        setName("painelInicial"); // NOI18N
        setLayout(new java.awt.BorderLayout());

        rotuloDescricao.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        rotuloDescricao.setText("<html>Este plugin utiliza um Layout de Cartão (Card Layout) para alternar entre diversos painéis. Clique no botão \"Avançar\" para ir ao próximo painel.<br><br>Clique no botão \"Testar\" para exibir o código fonte do usuário em uma nova janela.</html>");
        rotuloDescricao.setVerticalAlignment(javax.swing.SwingConstants.TOP);
        rotuloDescricao.setBorder(javax.swing.BorderFactory.createEmptyBorder(8, 8, 8, 8));
        add(rotuloDescricao, java.awt.BorderLayout.NORTH);

        painelCentro.setBorder(javax.swing.BorderFactory.createEmptyBorder(8, 8, 8, 8));

        botaoPainelFlutuante.setText("Clique para exibir um painel flutuante");
        botaoPainelFlutuante.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botaoPainelFlutuanteActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout painelCentroLayout = new javax.swing.GroupLayout(painelCentro);
        painelCentro.setLayout(painelCentroLayout);
        painelCentroLayout.setHorizontalGroup(
            painelCentroLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(botaoPainelFlutuante, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 259, Short.MAX_VALUE)
        );
        painelCentroLayout.setVerticalGroup(
            painelCentroLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, painelCentroLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(botaoPainelFlutuante, javax.swing.GroupLayout.DEFAULT_SIZE, 42, Short.MAX_VALUE)
                .addContainerGap())
        );

        add(painelCentro, java.awt.BorderLayout.CENTER);

        painelBotoes.setPreferredSize(new java.awt.Dimension(293, 60));

        botaoAvancar.setText("Avançar");
        botaoAvancar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        botaoAvancar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botaoAvancarActionPerformed(evt);
            }
        });

        botaoTestar.setText("Testar");
        botaoTestar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        botaoTestar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botaoTestarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout painelBotoesLayout = new javax.swing.GroupLayout(painelBotoes);
        painelBotoes.setLayout(painelBotoesLayout);
        painelBotoesLayout.setHorizontalGroup(
            painelBotoesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, painelBotoesLayout.createSequentialGroup()
                .addContainerGap(27, Short.MAX_VALUE)
                .addComponent(botaoTestar, javax.swing.GroupLayout.PREFERRED_SIZE, 114, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(botaoAvancar, javax.swing.GroupLayout.PREFERRED_SIZE, 114, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
            .addComponent(separador)
        );
        painelBotoesLayout.setVerticalGroup(
            painelBotoesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, painelBotoesLayout.createSequentialGroup()
                .addComponent(separador, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(painelBotoesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(botaoAvancar, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(botaoTestar, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        add(painelBotoes, java.awt.BorderLayout.SOUTH);
    }// </editor-fold>//GEN-END:initComponents

    private void botaoTestarActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_botaoTestarActionPerformed
    {//GEN-HEADEREND:event_botaoTestarActionPerformed
        String codigoFonte = plugin.getUtilizador().obterCodigoFonteUsuario();

        janelaCdigoFonte.setCodigoFonte(codigoFonte);
        janelaCdigoFonte.setLocationRelativeTo(null);
        janelaCdigoFonte.setVisible(true);
    }//GEN-LAST:event_botaoTestarActionPerformed

    private void botaoAvancarActionPerformed(java.awt.event.ActionEvent evt)//GEN-FIRST:event_botaoAvancarActionPerformed
    {//GEN-HEADEREND:event_botaoAvancarActionPerformed
        VisaoPluginExemplo visao = (VisaoPluginExemplo) plugin.getVisao();
        visao.exibirPainelImagem();
    }//GEN-LAST:event_botaoAvancarActionPerformed

    private void botaoPainelFlutuanteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botaoPainelFlutuanteActionPerformed
        
        if (botaoPainelFlutuante.isSelected())
        {
            plugin.getUtilizador().exibirPainelFlutuante(botaoPainelFlutuante, painelFlutuante, true);
        }
        else
        {
            plugin.getUtilizador().ocultarPainelFlutuante();
        }
    }//GEN-LAST:event_botaoPainelFlutuanteActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botaoAvancar;
    private javax.swing.JToggleButton botaoPainelFlutuante;
    private javax.swing.JButton botaoTestar;
    private javax.swing.JPanel painelBotoes;
    private javax.swing.JPanel painelCentro;
    private javax.swing.JLabel rotuloDescricao;
    private javax.swing.JSeparator separador;
    // End of variables declaration//GEN-END:variables

    public void alternarPainelFlutuante() 
    {
        if (botaoPainelFlutuante.isSelected())
        {
            plugin.getUtilizador().ocultarPainelFlutuante();
        }
        else
        {
            plugin.getUtilizador().exibirPainelFlutuante(botaoPainelFlutuante, painelFlutuante, true);
        }
        
        botaoPainelFlutuante.setSelected(!botaoPainelFlutuante.isSelected());
    }
}
