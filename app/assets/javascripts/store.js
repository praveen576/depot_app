$(document).ready( function() {
  
  $('.store .entry > img').click(function(){
    $(this).parent().find(':submit').click()
  });

  $('#search_form').submit(function() {  
      var valuesToSubmit = $(this).serialize();
      $.ajax({
          type: "GET",
          url: $(this).attr('action'), //sumbits it to the given url of the form
          data: valuesToSubmit,
          dataType: "script" // you want a difference between normal and ajax-calls, and json is standard
      }).success(function(response_string){
          console.log("success");
      });
      return false; // prevents normal behaviour
  });

});
