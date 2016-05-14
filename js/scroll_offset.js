    var offset = 80;
    $('.navbar-fixed-top li a[href^="#"]').click(function(event) {
        event.preventDefault();
      var hash = this.hash;
      $('html, body').animate({
        scrollTop: $(this.hash).offset().top - offset
      }, 500, function(){
        history.pushState(null, null, hash);
      });
    });