<?php
class Fornecedor {

    private $db;

    public function __construct() {
        $this->db = new Database();
    }

    //Inserir fornecedor
    public function cadastrar($pessoaJuridica, $fornecedor, $telefones) {
        $sql = "SELECT * FROM pessoaJuridica WHERE cnpj = '" . $pessoaJuridica['cnpj'] . "';";
        $resPessoaJuridica = $this->db->retornar_dados($sql, TRUE);

        if(empty($resPessoaJuridica)) {
            $colunas = "`" . implode( "`, `", array_keys($pessoaJuridica)) . "`";
            $valores = "'" . implode("', '" ,$pessoaJuridica) . "'";

            $sql = "INSERT INTO pessoaJuridica({$colunas}) values ({$valores})";

            $idPessoaJuridica = $this->db->executar_query_ult_id($sql);
        } else {
            $idPessoaJuridica = $resPessoaJuridica['idPessoaJuridica'];
        }

        $fornecedor['idPessoaJuridica'] = $idPessoaJuridica;
        $colunas = "`" . implode("`, `", array_keys($fornecedor)) . "`";
        $valores = "'" . implode("', '", $fornecedor) . "'";

        $sql = "INSERT INTO fornecedor({$colunas}) values ({$valores})";

        $idFornecedor = $this->db->executar_query_ult_id($sql);

    
        $sql = "DELETE FROM telefonePesJuridica WHERE idPessoaJuridica = " . $idPessoaJuridica . ";";

        $resultado_delete_tel = $this->db->executar_query($sql);

        foreach($telefones as $indice => $telefone) {
            $dados_tel['idPessoaJuridica'] = $idPessoaJuridica;
            $dados_tel['telefone'] = preg_replace('/[^0-9]/', '', $telefone);
            $colunas = "`" . implode("`, `", array_keys($dados_tel)) . "`";
            $valores = "'" . implode("', '", $dados_tel) . "'";
    
            $sql = "INSERT INTO telefonePesJuridica({$colunas}) values ({$valores})";

            $resultado_tel = $this->db->executar_query($sql);
        }

        return $idFornecedor;
    }

    public function atualizar($idPessoaJuridica, $pessoaJuridica, $idFornecedor, $fornecedor, $telefones) {
        $campos = "";
        foreach($pessoaJuridica as $indice => $valor) {
            if(!empty($campos)) {
                $campos .= ", ";
            }
            $campos .= "`" . $indice . "` = ";
            if($valor === NULL) {
                $campos .= "NULL";
            } else {
                $campos .= "'" . $valor . "'";
            }
        }

        $sql = "UPDATE pessoaJuridica SET {$campos} WHERE idPessoaJuridica = " . $idPessoaJuridica;

        $pessoaAtualizada = $this->db->executar_query($sql);

        $campos = "";
        foreach($fornecedor as $indice => $valor) {
            if(!empty($campos)) {
                $campos .= ", ";
            }
            $campos .= "`" . $indice . "` = ";
            if($valor === NULL) {
                $campos .= "NULL";
            } else {
                $campos .= "'" . $valor . "'";
            }
        }

        $sql = "UPDATE fornecedor SET {$campos} WHERE idFornecedor = " . $idFornecedor;

        $fornecedorAtualizado = $this->db->executar_query($sql);
        
        $sql = "DELETE FROM telefonePesJuridica WHERE idPessoaJuridica = " . $idPessoaJuridica . ";";

        $resultado_delete_tel = $this->db->executar_query($sql);

        foreach($telefones as $indice => $telefone) {
            $dados_tel['idPessoaJuridica'] = $idPessoaJuridica;
            $dados_tel['telefone'] = preg_replace('/[^0-9]/', '', $telefone);
            $colunas = "`" . implode("`, `", array_keys($dados_tel)) . "`";
            $valores = "'" . implode("', '", $dados_tel) . "'";
    
            $sql = "INSERT INTO telefonePesJuridica({$colunas}) values ({$valores})";

            $resultadoTel = $this->db->executar_query($sql);
        }

        return $pessoaAtualizada && $fornecedorAtualizado && $resultadoTel;
    }

    //Lista todos os fornecedores
    public function listar() {
        // Cria Query
        $sql = "SELECT * FROM fornecedorCompleto;";

        $resultado = $this->db->retornar_dados($sql);
        
        return $resultado;
    }

    //Listar fornecedor por código
    public function consultar($idFornecedor) {
        $sql = "SELECT * from fornecedorCompleto WHERE idFornecedor = $idFornecedor";

        $resultado = $this->db->retornar_dados($sql, TRUE);
        
        return $resultado;
    }

    //Deletar fornecedor
    public function deletar($idFornecedor) {
        // Cria Query
        $sql = "DELETE FROM fornecedor WHERE idFornecedor = '$idFornecedor'";

        $resultado = $this->db->executar_query($sql);
        
        return $resultado;
    }

}

?>