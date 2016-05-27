$(document).ready( function() {
  $('.store .entry > img').click(function(){
    $(this).parent().find(':submit').click()
 });
});
