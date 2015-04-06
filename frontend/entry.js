var $ = require('jquery');

require('./scss/main.scss');

$(function() {
  $(document).on('click', '.js-submit-conversion', handleConvertClick);

  function handleConvertClick() {
    var c = $('.js-original-code').val()

    $.ajax({
      method: 'GET',
      url: '/snippet',
      // contentType: "application/json; charset=utf-8",
      // dataType: "json",
      data: "code=" + c,
      success: handleAjaxSuccess
    });

    function handleAjaxSuccess(data) {
      var pfCode = data.code
      $('.js-pointfree-code').text(pfCode)
    }
  }
});
