$('.check-us-out').on('click', function() {
	$('html, body').animate({ scrollTop: $('.about-us').offset().top });
});

$('.contact-us').on('click', function() {
	$('html, body').animate({ scrollTop: $('.get-in-touch').offset().top });
});

if($('.contact-form-errors').length) {
	$('html, body').animate({ scrollTop: $('.contact-form-errors').offset().top });
}
