// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require cable
//= require bootstrap
//= require cloudinary
//= require social-share-button
//= require jquery.raty
//= require ratyrate
//= require turbolinks
//= require_tree .
//= require gmaps/google

function handleStar(i) {
  var j,k;
  document.getElementById("star").value = i;
  for (j = 0; j < i; j++) {
    var idname = 'star'.concat(j);
    document.getElementById(idname).className = "btn btn-success btn-sm";
  }

  for (k = i; k < 5; k++) {
    var idname = 'star'.concat(k);
    document.getElementById(idname).className = "btn btn-grey btn-sm";

  }
}
