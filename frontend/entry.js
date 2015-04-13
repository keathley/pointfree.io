var $ = require('jquery');

require('./scss/main.scss');

$(function() {
  $(document).on('click', '.js-submit-conversion', handleConvert);
  $(".js-original-code").on("keydown", handleConvert)
  $('.js-pointfree-code').click(onPointfreeClick)

  function onPointfreeClick(e) {
    $(this).select()
  }

  function handleConvert(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode && keyCode !== 13 && keyCode !== 1) return;

    var c = $('.js-original-code').val()
    var data = "code=" + encodeURIComponent(c)

    console.log(data)

    $.ajax({
      method: 'GET',
      url: '/snippet',
      data: data,
      success: handleAjaxSuccess
    });

    function handleAjaxSuccess(data) {
      var pfCode = data.code
      var $pfInput = $('.js-pointfree-code')
      $pfInput.val(pfCode)
    }
  }
});
