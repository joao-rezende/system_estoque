<?php
/**
 * Class Template
 * @package SystemBiblioteca
 */
class Template
{
    /**
     * @var string
     */
    private $caminho_template;


    /**
     * @var string
     */
    private $caminho_views = BASE_PATH . "views/";

    /**
     * @var array
     */
    private $parametros = [];

    /**
     * Template constructor.
     * @param string $caminho_template
     * @param array $parametros
     */
    public function __construct(string $caminho_template, array $parametros = [])
    {
        $this->caminho_template = $caminho_template;
        $this->parametros = $parametros;
    }


    /**
     * @param string $view
     * @param array $variaveis
     * @throws \Exception
     */
    private function _render_view(string $view, array $variaveis) {
        if (!file_exists($arquivo = $this->caminho_views . $view)) {
            throw new \Exception(sprintf('O arquivo %s não foi encontrado.', $view));
        }

        extract(array_merge($variaveis, ['template' => $this]));

        ob_start();

        include ($arquivo);

        return ob_get_clean();
    }


    /**
     * @param string $view
     * @param array $variaveis
     */
    public function render(string $view, array $variaveis = [])
    {
        $conteudo = $this->_render_view($view, $variaveis);

        include($this->caminho_template);
    }
}