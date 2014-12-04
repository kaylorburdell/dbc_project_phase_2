$(document).ready(function() {
  $('.container-login').on('click', '.delete_btn', function(event) {
    event.preventDefault();
    $target = $(event.target);
    $target.val("Deleting...");
    $target.attr("disabled", "true");
    action = $target.parent().attr('action');

    $.ajax({
      url: action,
      type: "DELETE"
    }).done(function() {
      $target.parents('.topic').remove();
    });
  });
});
