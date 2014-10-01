package br.univali.portugol.plugin.exemplo.acoes;

import java.awt.Image;
import java.awt.event.ActionEvent;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.AbstractAction;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

/**
 *
 * @author Luiz Fernando Noschang
 */
public final class AcaoPersonalizadaEstatica extends AbstractAction
{
    public AcaoPersonalizadaEstatica()
    {
        super("Ação personalizada estática", carregarIcone());
    }

    private static Icon carregarIcone()
    {
        try
        {
            String caminho = "br/univali/portugol/plugin/exemplo/imagens/caution_biohazard.png";
            Image imagem = ImageIO.read(AcaoPersonalizadaEstatica.class.getClassLoader().getResourceAsStream(caminho));

            return new ImageIcon(imagem);
        }
        catch (IOException ex)
        {
            return null;
        }
    }

    @Override
    public void actionPerformed(ActionEvent e)
    {
        JOptionPane.showMessageDialog(null, "O plugin executou uma ação personalizada estática!!", "Plugin Exemplo", JOptionPane.INFORMATION_MESSAGE);
    }
}
