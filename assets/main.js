// ========================== BURGEUR MENU ==========================
$(function () {
  //when you clise menu
  $('.closebtn').click(function () {
    $('.overlay').css('width', '0');
  });

  //when you open menu
  $('.burger-button').click(function () {
    $('.overlay').css('width', '100%');
  });
});



// ==========================  MODAL ==========================
$(function () {

  //when gallery image is clicked 
  $('.gallery-grid-item img').click(function () {
    $('.gallery-modal').css('display', 'block');
    var source = $(this).attr("src");
    var alter = $(this).attr("alt");
    $('#captionShow').text(alter);
    $('#imgShow').attr({
      src: source,
      alt: alter
    });
  });

  //when close button of gallery image is clicked
  $('.modal-close').click(function () {
    $('.gallery-modal').css('display', 'none');
  })
});


// ==========================  PARRLLAX ==========================

$(function () {
  var top = $('#community h1').offset().top;
  $(window).scroll(function () {
    var value = $(this).scrollTop();
    $('#community h1').css('top', top + value * 0.5 + 'px');
    $('#community h2').css('top', top + value * 0.3 + 'px');
  });
});


// ==========================  MAIL BUTTON ==========================
$(function () {
  $('#contact-form').submit(function () {
    $('#sendDone').text("Thank you for your messages! I will read it as soon as Possible :)");
    return false;
  });
});


// ==========================  Sgin up Confirmation Pages ==========================
var username;
$(function () {
  $('.signup-content').submit(function () {
    var password = $("#psw").val();
    var confrimPassword = $("#conPsw").val();
    if (password == confrimPassword) {
      alert("Thank You for your sign up !!");
    } else {
      $('#messageSignUp').text("Your password is not correct. Please try again.");
      return false;
    }
  });
});

