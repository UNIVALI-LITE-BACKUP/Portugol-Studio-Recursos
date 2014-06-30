
String.prototype.escapeHtml = function()
{
    return this.replace(/&/g, '&amp;')
    .replace(/>/g, '&gt;')
    .replace(/</g, '&lt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
};

$(document).ready(function()
{
    $(".codigo-portugol").each(function(indice, elemento)
    {                
        var ultimoIndice = $(".codigo-portugol").length - 1;
        var arquivo = elemento.dataset.file;
        var titulo = elemento.dataset.title;

        $.get(arquivo, function(conteudo)
        {
            var cabecalho = $("<div>" + titulo.escapeHtml() + "</div>").attr
            ({
                class: "cabecalho-codigo-portugol"                
            });
            
            $(elemento).append(cabecalho).append($("<pre>" + conteudo.escapeHtml() + "</pre>").attr
            ({
                name: "code", class: "portugol:nocontrols"
            }));
            
            if (indice === ultimoIndice)
            {
                dp.SyntaxHighlighter.HighlightAll('code');
            }

        }, "text");
    });
});
    