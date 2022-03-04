$("#modal-alerta").on("hidden.bs.modal", function() {
    $("#modal-alerta .modal-body").text("");
    $("#modal-alerta .modal-footer .text-left").html("");
    $("#modal-alerta .modal-footer .text-right").html("");
});

function modalAlerta(msg) {
    $("#modal-alerta .modal-body").text(msg);

    const $btnOk = $("<button></button>", {class: "btn btn-primary m-0", "data-dismiss": "modal"})
                    .append($("<span></span>", {class: "fa fa-check"}))
                    .append(" OK");
    
    $("#modal-alerta .modal-footer .text-right").append($btnOk);

    $("#modal-alerta").modal("show");
}

function modalConfimar(msg, callback) {
    $("#modal-alerta .modal-body").text(msg);

    const $btnNao = $("<button></button>", {id: "btn-nao", class: "btn btn-danger m-0", "data-dismiss": "modal"})
                    .append($("<span></span>", {class: "fa fa-remove"}))
                    .append(" Não");

    $("#modal-alerta .modal-footer .text-left").append($btnNao);

    const $btnSim = $("<button></button>", {id: "btn-sim", class: "btn btn-success m-0", "data-dismiss": "modal"})
                    .append($("<span></span>", {class: "fa fa-check"}))
                    .append(" Sim");

    $("#modal-alerta .modal-footer .text-right").append($btnSim);

    $("#btn-sim").on("click", function() {
        callback(true);
    });

    $("#btn-nao").on("click", function() {
        callback(false);
    });

    $("#modal-alerta").modal("show");
}

$(document).ready(function() {
    var menu = $('ul#navigation');
    if(menu.length){
        menu.slicknav({
            prependTo: ".mobile_menu",
            closedSymbol: '+',
            openedSymbol:'-'
        });
    };

    if($(".notificacao").length) {
        setTimeout(() => {
            $(".notificacao").fadeOut(500, function() {
                $(".notificacao").remove();
            });
        }, 3000)
    }
    
    $(".btn-excluir-fornecedor").on("click", function() {
        const $btn = $(this);
        modalConfimar("Deseja excluir o Fornecedor?", function(excluir) {
            if(excluir) {
                window.location.href = $btn.data("url");
            }
        });
    });

    $("#tabela-telefones tbody").on("click", ".btn-excluir-telefone", function() {
        const $btn = $(this);
        $btn.parents("tr").fadeOut(550, function() {
            $btn.parents("tr").remove();
        });
    });

    $(".btn-adicionar-tel").on("click", function() {
        const posicao = $("#tabela-telefones tbody tr").length + 1;
        const $tr = $("<tr></tr>").appendTo($("#tabela-telefones tbody"));
        const $tdInput = $("<td></td>").appendTo($tr);
        const $tdAcao = $("<td></td>", {class: "text-center"}).appendTo($tr);
        $("<input>", {class: "form-control", name: "telefones[]", placeholder: "NXXXX-XXXX", minlength: 9, maxlength: 10, type: "tel"}).appendTo($tdInput);
        const $btnExcluir = $("<button></button>", {class: "btn btn-sm btn-link btn-excluir-telefone text-danger line-1", type: "button"}).appendTo($tdAcao);
        $("<span></span>", {class: "fa fa-trash"}).appendTo($btnExcluir);
    });

    $("[data-toggle=tooltip]").tooltip();
});