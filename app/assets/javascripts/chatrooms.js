$(document).on('turbolinks:load', function() {
  submitNewMessage();
});

submitNewMessage = function(){
  $('textarea#personal_message_body').keydown(function(e) {
    if (e.keyCode == 13) {
         $(this).closest("form").submit();
        e.preventDefault();
        return false;
        return false;
     }
  });
}

$(function(){
  $(document).on("click", "#addClass", function(){
    $('#qnimate').addClass('popup-box-on');
    $("#conversation-main").scrollTop($("#conversation-main")[0].scrollHeight);
  });

  $(document).on("click", "#removeClass", function(){
    $('#qnimate').removeClass('popup-box-on');
  });
  $('#addClass').click();
})

