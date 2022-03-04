<?php 

class Database {

    private $conexao;
    
    public function __construct() {}

    private function conectar() {
        $this->conexao = new mysqli(HOST, USER, SENHA, BD);

        if (mysqli_connect_errno()) {
            echo "Falha ao tentar conectar ao MySQL: " . mysqli_connect_error();
            exit;
        }
    }

    public function executar_query_ult_id($query) {
        $this->conectar();

        $resultado = $this->conexao->query($query);

        if(!$resultado && ini_get('display_errors') != 0) {
            echo "ERRO SQL: " . $this->conexao->error;
            exit();
        }

        $utlimo_id = $this->conexao->insert_id;

        $this->conexao->close();

        return $utlimo_id;
    }

    public function executar_query($query) {
        $this->conectar();

        $resultado = $this->conexao->query($query);

        if(!$resultado && ini_get('display_errors') != 0) {
            echo "ERRO SQL: " . $this->conexao->error;
            exit();
        }

        $this->conexao->close();

        return $resultado;
    }

    public function retornar_dados($query, $linha = FALSE) {
        try{
            $resultado_mysql = $this->executar_query($query);
        
            if(!$linha) {
                $dados = [];
                while($linha = $resultado_mysql->fetch_assoc()) {
                    $dados[] = $linha;
                }
            } else {
                $dados = $resultado_mysql->fetch_assoc();
            }
            return $dados;
        } catch(Exception $e) {
            echo "ERRO: [database.php / retornar_dados] -> ";
            echo $e->getMessage() ;
            throw new Exception($e->getMessage());
        }
    }

}