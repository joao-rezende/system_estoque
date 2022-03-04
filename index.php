<?php 

ini_set('display_errors', 1);


if(!file_exists('configs/config.php')) {
    echo "Nenhum arquivo de configuração foi encontrado";
    exit(0);
}

define("BASE_PATH", $_SERVER['DOCUMENT_ROOT'] . "/");

if (!session_id()) session_start();

require_once 'configs/config.php';
require_once 'libraries/database.php';

$uri = $_SERVER['REQUEST_URI'];
$uri = explode("?", $uri)[0];

$tamanho = mb_strlen("/system_estoque/index.php/");
$uri = substr($uri, $tamanho, mb_strlen($uri));
$uri = explode("/", $uri);

$classe = !empty($uri[0]) ? mb_strtolower($uri[0]) : "fornecedor";
$metodo = isset($uri[1]) ? $uri[1] : "index";

$classe .= 'Controller';

if(!file_exists('controllers/' . $classe . '.php')) {
    echo "ERRO 404 - Página não encontrada";
    exit(0);
}

require_once 'controllers/' . $classe . '.php';

$obj = new $classe();

if(!method_exists($obj, $metodo)) {
    echo "ERRO 404 - Página não encontrada";
    exit(0);
}

$obj->$metodo();