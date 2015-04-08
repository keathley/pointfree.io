var $ = require('jquery');

require('./scss/main.scss');

$(function() {
  $(document).on('click', '.js-submit-conversion', handleConvert);
  $(".js-original-code").on("keydown", handleConvert)

  function handleConvert(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode && keyCode !== 13 && keyCode !== 1) return;

    var c = $('.js-original-code').val()

    $.ajax({
      method: 'GET',
      url: '/snippet',
      data: "code=" + c,
      success: handleAjaxSuccess
    });

    function handleAjaxSuccess(data) {
      var pfCode = data.code
      $('.js-pointfree-code').text(pfCode)
    }
  }
});
