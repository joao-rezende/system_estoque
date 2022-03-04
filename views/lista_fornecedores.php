<div class="container">
    <div class="row mb-3">
        <div class="col-6">
            <h2 class="titulo m-0">Fornecedores</h2>
        </div>
        <div class="col-6 text-right">
            <a href="<?php echo SITE_URL . "fornecedor/adicionar"; ?>" class="btn btn-success"><span class="fa fa-plus"></span> Adicionar</a>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="table-responsive"> 
                <table class="table table-hover table-sm">
                    <thead class="">
                        <tr>
                            <th>CNPJ</th>
                            <th>Razão Social</th>
                            <th>Fantasia</th>
                            <th>Ramo Atividade</th>
                            <th>E-mail</th>
                            <th>Telefones</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        foreach($fornecedores as $fornecedor) {
                            $telefones = explode(",", $fornecedor['telefones']);
                            $strTelefones = "";
                            foreach($telefones as $indice => $telefone) {
                                if($indice > 0) {
                                    $strTelefones .= ", ";
                                }
                                $strTelefones .= formatar_telefone($telefone);
                            }
                            ?>
                            <tr>
                                <td><?= formatar_cnpj($fornecedor['cnpj']); ?></td>
                                <td><?= $fornecedor['razaoSocial']; ?></td>
                                <td><?= $fornecedor['fantasia']; ?></td>
                                <td><?= $fornecedor['ramoAtividade']; ?></td>
                                <td><?= $fornecedor['email']; ?></td>
                                <td><?= $strTelefones; ?></td>
                                <td class="col-botao">
                                    <a href="<?php echo SITE_URL . "fornecedor/editar?id=" . $fornecedor['idFornecedor']; ?>" class="btn btn-sm btn-link line-1"><span class="fa fa-pencil"></span></a>
                                    <button data-url="<?php echo SITE_URL . "fornecedor/excluir?id=" . $fornecedor['idFornecedor']; ?>" type="button" class="btn btn-sm btn-link btn-excluir-fornecedor text-danger line-1"><span class="fa fa-trash"></span></button>
                                </td>
                            </tr>
                            <?php
                        }
                        ?>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>