<?php

if (!function_exists('formatar_cpf')) {

    function formatar_cpf($cpf) {
        return substr($cpf, 0, 3) . "." . substr($cpf, 3, 3) . "." . substr($cpf, 6, 3) . "-" . substr($cpf, 9, 2);
    }
    
}

if (!function_exists('formatar_cnpj')) {

    function formatar_cnpj($cnpj) {
        return substr($cnpj, 0, 2) . "." . substr($cnpj, 2, 3) . "." . substr($cnpj, 5, 3) . "/" . substr($cnpj, 8, 4) . "-" . substr($cnpj, 12 , 2);
    }
    
}

if (!function_exists('formatar_data')) {

    function formatar_data($data) {
        return substr($data, 8, 2) . "/" . substr($data, 5, 2) . "/" . substr($data, 0, 4);
    }
    
}

if (!function_exists('formatar_cep')) {

    function formatar_cep($data) {
        return substr($data, 0, 5) . "-" . substr($data, 5, 3);
    }
    
}

if (!function_exists('formatar_telefone')) {

    function formatar_telefone($telefone) {
        if(strlen($telefone) === 8) {
            return substr($telefone, 0, 4) . "-" . substr($telefone, 4, 4);
        } else if(strlen($telefone) === 9) {
            return substr($telefone, 0, 5) . "-" . substr($telefone, 5, 4);
        }

        return $telefone;
    }
    
}