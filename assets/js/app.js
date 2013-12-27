$('.check-us-out').on('click', function() {
	$('html, body').animate({ scrollTop: $('.how-we-roll').offset().top + 8 });
});

$('.get-in-touch .minimal-logo').on('click', function() {
	$('html, body').animate({ scrollTop: 0 });
});

if($('.contact-form-errors').length) {
	$('html, body').animate({ scrollTop: $('.contact-form-errors').offset().top });
}
