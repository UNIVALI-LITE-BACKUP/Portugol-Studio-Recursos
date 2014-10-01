package br.univali.portugol.plugin.exemplo;

import br.univali.portugol.plugin.exemplo.acoes.AcaoPersonalizadaEstatica;
import br.univali.ps.plugins.base.Plugin;
import br.univali.ps.plugins.base.UtilizadorPlugins;
import br.univali.ps.plugins.base.VisaoPlugin;

/**
 *
 * @author Luiz Fernando Noschang
 */
public final class PluginExemplo extends Plugin
{
    private final VisaoPlugin visao = new VisaoPluginExemplo(this);
    
    private UtilizadorPlugins utilizador;
    
    public PluginExemplo()
    {
        
    }

    @Override
    protected void inicializar(UtilizadorPlugins utilizador)
    {
        this.utilizador = utilizador;
        this.utilizador.instalarAcaoPlugin(this, new AcaoPersonalizadaEstatica());
    }

    @Override
    public VisaoPlugin getVisao()
    {
        return visao;
    }

    public UtilizadorPlugins getUtilizador()
    {
        return utilizador;
    }
}
