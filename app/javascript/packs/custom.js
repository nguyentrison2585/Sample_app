$(document).ready(function() {
  $('#micropost_image').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(I18n.t('max_size_file'));
    }
  });
  var slideIndex = 1;
  showDivs(slideIndex);

  $('.w3-display-left')[0].addEventListener('click', function(){plusDivs(-1);});
  $('.w3-display-right')[0].addEventListener('click', function(){plusDivs(1);});

  function plusDivs(n) {
    console.log('click');
    showDivs(slideIndex += n);
  }

  function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("mySlides");
    if (n > x.length) {slideIndex = 1}
    if (n < 1) {slideIndex = x.length}
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none";
    }
    x[slideIndex-1].style.display = "block";
  }
});
