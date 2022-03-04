<?php

require_once './libraries/template.php';
require_once './helpers/formatacao.php';
require_once './models/Fornecedor.php';

class fornecedorController {
    private $template;
    private $fornecedor;

    function __construct() {
        $this->template = new Template(BASE_PATH . "views/template/geral.php");
        $this->fornecedor = new Fornecedor();
    }

    public function index() {
        $dados['fornecedores'] = $this->fornecedor->listar(1);
        $this->template->render("lista_fornecedores.php", $dados);
    }

    public function adicionar() {
        $this->template->render("form_fornecedores.php");
    }

    public function salvar() {
        $pessoaJuridica = [
            "cnpj" => preg_replace('/[^0-9]/', '', $_POST['cnpj']),
            "razaoSocial" => $_POST['razaoSocial'],
            "fantasia" => $_POST['fantasia'],
            "cep" => preg_replace('/[^0-9]/', '', $_POST['cep']),
            "logradouro" => $_POST['logradouro'],
            "numero" => !empty($_POST['numero']) ? $_POST['numero'] : NULL,
            "complemento" => $_POST['complemento'],
            "bairro" => $_POST['bairro'],
            "cidade" => $_POST['cidade'],
            "estado" => $_POST['estado']
        ];

        $fornecedor = [
            "ramoAtividade" => $_POST['ramoAtividade'],
            "email" => $_POST['email'],
        ];

        $telefones = $_POST['telefones'];

        if(!isset($_POST['idFornecedor'])) {
            $idFornecedor = $this->fornecedor->cadastrar($pessoaJuridica, $fornecedor, $telefones);
            $_SESSION['msgNotifSuccesso'] = "Funcionário cadastrado com sucesso";
        } else {
            $idPessoaJuridica = $_POST['idPessoaJuridica'];
            $idFornecedor = $_POST['idFornecedor'];

            $atualizado = $this->fornecedor->atualizar($idPessoaJuridica, $pessoaJuridica, $idFornecedor, $fornecedor, $telefones);

            if(!$atualizado) {
                $_SESSION['msgNotifErro'] = "Erro na atualização do fornecedor";
            }
            $_SESSION['msgNotifSuccesso'] = "Funcionário atualizado com sucesso";
        }

        
        header("Location: " . SITE_URL . "fornecedor");
    }

    public function editar() {
        $idFornecedor = isset($_GET['id']) ? $_GET['id'] : NULL;

        if(empty($idFornecedor)) {
            $_SESSION['msgNotifErro'] = "Nenhum código foi enviado";
            header("Location: " . SITE_URL . "fornecedor");
            return;
        }

        $fornecedor = $this->fornecedor->consultar($idFornecedor);
        
        if(empty($fornecedor)) {
            $_SESSION['msgNotifErro'] = "Fornecedor não encontrado";
            header("Location: " . SITE_URL . "fornecedor");
            return;
        }
        
        $fornecedor['telefones'] = explode(",", $fornecedor['telefones']);
        $dados['fornecedor'] = $fornecedor;
        
        $this->template->render("form_fornecedores.php", $dados);
    }

    public function excluir() {
        $idFornecedor = isset($_GET['id']) ? $_GET['id'] : NULL;

        if(empty($idFornecedor)) {
            $_SESSION['msgNotifErro'] = "Nenhum código foi enviado";
            header("Location: " . SITE_URL . "fornecedor");
            return;
        }

        $fornecedor = $this->fornecedor->consultar($idFornecedor);
        
        if(empty($fornecedor)) {
            $_SESSION['msgNotifErro'] = "Fornecedor não encontrado";
            header("Location: " . SITE_URL . "fornecedor");
            return;
        }
        
        $this->fornecedor->deletar($fornecedor['idFornecedor']);
        $_SESSION['msgNotifSuccesso'] = "Fornecedor excluído com sucesso";
        header("Location: " . SITE_URL . "fornecedor");
    }
    
}