<div class="container">
    <div class="row mb-3">
        <div class="col-6">
            <h2 class="titulo m-0"><?= (!isset($fornecedor)) ? "Novo Fornecedor" : "Editar Fornecedor"; ?></h2>
        </div>
    </div>
    <hr>
    <form action="<?php echo SITE_URL . "fornecedor/salvar"; ?>" method="POST" enctype='multipart/form-data'>
        <?php
        if(isset($fornecedor))
        {
            ?>
            <input type="hidden" name="idPessoaJuridica" value="<?= $fornecedor['idPessoaJuridica']; ?>">
            <input type="hidden" name="idFornecedor" value="<?= $fornecedor['idFornecedor']; ?>">
            <?php
        }
        ?>
        <div class="form-group row">
            <label for="cnpj" class="col-sm-2 col-form-label">CNPJ:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="cnpj" name="cnpj" placeholder="CNPJ" value="<?= isset($fornecedor) ? $fornecedor['cnpj'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="razaoSocial" class="col-sm-2 col-form-label">Razão Social:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="razaoSocial" name="razaoSocial" placeholder="Razão Social" value="<?= isset($fornecedor) ? $fornecedor['razaoSocial'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="fantasia" class="col-sm-2 col-form-label">Fantasia:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="fantasia" name="fantasia" placeholder="Fantasia" value="<?= isset($fornecedor) ? $fornecedor['fantasia'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="ramoAtividade" class="col-sm-2 col-form-label">Ramo Atividade:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="ramoAtividade" name="ramoAtividade" placeholder="Ramo Atividade" value="<?= isset($fornecedor) ? $fornecedor['ramoAtividade'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">E-mail:</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="email" name="email" placeholder="E-mail" value="<?= isset($fornecedor) ? $fornecedor['email'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="cep" class="col-sm-2 col-form-label">CEP:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="cep" name="cep" placeholder="CEP" value="<?= isset($fornecedor) ? $fornecedor['cep'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="logradouro" class="col-sm-2 col-form-label">Logradouro:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="logradouro" name="logradouro" placeholder="Logradouro" value="<?= isset($fornecedor) ? $fornecedor['logradouro'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="numero" class="col-sm-2 col-form-label">Número:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="numero" name="numero" placeholder="Número" value="<?= isset($fornecedor) ? $fornecedor['numero'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="complemento" class="col-sm-2 col-form-label">Complemento:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="complemento" name="complemento" placeholder="Complemento" value="<?= isset($fornecedor) ? $fornecedor['complemento'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="bairro" class="col-sm-2 col-form-label">Bairro:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="bairro" name="bairro" placeholder="Bairro" value="<?= isset($fornecedor) ? $fornecedor['bairro'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="cidade" class="col-sm-2 col-form-label">Cidade:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="cidade" name="cidade" placeholder="Cidade" value="<?= isset($fornecedor) ? $fornecedor['cidade'] : ""; ?>">
            </div>
        </div>
        <div class="form-group row">
            <label for="estado" class="col-sm-2 col-form-label">Estado:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="estado" name="estado" placeholder="Estado" value="<?= isset($fornecedor) ? $fornecedor['estado'] : ""; ?>" maxlength="2">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-6 col-form-label">Telefones</label>
            <div class="col-6 text-right">
                <a class="btn btn-success btn-adicionar-tel" href="javascript:;"><span class="fa fa-plus"></span> Adicionar</a>
            </div>
            <div class="col-sm-12">
                <div class="table-responsive"> 
                    <table id="tabela-telefones" class="table table-hover table-sm">
                        <tbody>
                            <?php
                            if(isset($fornecedor['telefones'])) {
                                foreach($fornecedor['telefones'] as $telefone) {
                                    ?>
                                    <tr>
                                        <td>
                                            <input class="form-control" name="telefones[]" placeholder="NXXXX-XXXX" minlength="9" maxlength="10" type="tel" value="<?= formatar_telefone($telefone); ?>" />
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-link btn-excluir-telefone text-danger line-1" type="button">
                                                <span class="fa fa-trash"></span>
                                            </button>
                                        </td>
                                    </tr>
                                    <?php
                                }
                            }
                            ?>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <hr>
        <div class="form-group row">
            <div class="col-6">
                <a href="<?php echo SITE_URL . "fornecedor"; ?>" class="btn btn-danger"><span class="fa fa-remove"></span> Cancelar</a>
            </div>
            <div class="col-6 text-right">
                <button type="submit" class="btn btn-success"><span class="fa fa-save"></span> Salvar</button>
            </div>
        </div>
    </form>
</div>