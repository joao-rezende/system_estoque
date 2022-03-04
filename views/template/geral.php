<!doctype html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>System Estoque</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo URL_BASE . "assets/img/favicon.png"; ?>">
    <!-- Place favicon.ico in the root directory -->

    <!-- CSS here -->
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/bootstrap.min.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/owl.carousel.min.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/magnific-popup.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/font-awesome.min.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/themify-icons.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/nice-select.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/flaticon.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/gijgo.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/animate.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/slick.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/slicknav.css"; ?>">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css">

    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/hus/css/style.css"; ?>">
    <link rel="stylesheet" href="<?php echo URL_BASE . "assets/css/estilo.css"; ?>">
</head>

<body>
    <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

    <!-- header-start -->
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid p-0">
                    <div class="row align-items-center no-gutters">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo">
                                <a href="<?php echo SITE_URL; ?>">
                                    <h3>S<small>ystem</small> E<small>stoque</small></h3>
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- slider_area_start -->
    <div id="conteudo-template">
        <?php echo $conteudo; ?>
    </div>
    <!-- slider_area_end -->

    
    <div class="footer footer_bg_1">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <p class="copy_right">
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> Todos os direitos reservados | Este template foi produzido por <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        </p>
                    </div>
                    <div class="col-lg-4">
                        <a href="<?php echo SITE_URL; ?>">
                            <h2>S<small>ystem</small> E<small>stoque</small></h2>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="modal-alerta" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <div class="col-6 text-left p-0 m-0">
                        
                    </div>
                    <div class="col-6 text-right p-0 m-0">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php 
    if(!empty($_SESSION['msgNotifSuccesso'])) {
        ?>
        <div class="toast fade show notificacao" role="alert" aria-live="assertive" aria-atomic="true" style="position: absolute; right: 20px; top: 40px; z-index: 9999;">
            <div class="toast-header">
                <span class="fa fa-check-circle text-success" style="font-size: 17px;"></span>
                <strong class="ml-1 mr-auto">Successo</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                <?php echo $_SESSION['msgNotifSuccesso']; ?>
            </div>
        </div>
        <?php
        $_SESSION['msgNotifSuccesso'] = NULL;
    } 
    ?>

    <?php 
    if(!empty($_SESSION['msgNotifErro'])) {
        ?>
        <div class="toast fade show notificacao" role="alert" aria-live="assertive" aria-atomic="true" style="position: absolute; right: 20px; top: 40px; z-index: 9999;">
            <div class="toast-header">
                <span class="fa fa-exclamation-triangle text-danger" style="font-size: 17px;"></span>
                <strong class="ml-1 mr-auto">Erro</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                <?php echo $_SESSION['msgNotifErro']; ?>
            </div>
        </div>
        <?php
        $_SESSION['msgNotifErro'] = NULL;
    } 
    ?>
        
    <!-- JS here -->
    <script src="<?php echo URL_BASE . "assets/hus/js/vendor/modernizr-3.5.0.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/vendor/jquery-1.12.4.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/popper.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/bootstrap.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/owl.carousel.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/isotope.pkgd.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/ajax-form.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/waypoints.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.counterup.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/imagesloaded.pkgd.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/scrollIt.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.scrollUp.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/wow.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/nice-select.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.slicknav.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.magnific-popup.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/plugins.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/gijgo.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/slick.min.js"; ?>"></script>



    <!--contact js-->
    <script src="<?php echo URL_BASE . "assets/hus/js/contact.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.ajaxchimp.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.form.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/jquery.validate.min.js"; ?>"></script>
    <script src="<?php echo URL_BASE . "assets/hus/js/mail-script.js"; ?>"></script>

    <script src="<?php echo URL_BASE . "assets/js/main.js"; ?>"></script>
</body>

</html>