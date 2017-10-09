// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
let handlebars = require("handlebars");

handlebars.registerHelper('num_likes', function(json) {
    return Object.keys(json).length;
});
//
// handlebars.registerHelper('button_html', function(data, user_id, post_id) {
//
//     var label = "like";
//     for (var index = 0; index < data.length; ++index) {
//
//      var key = data[index];
//      console.log(key);
//      console.log(key["user_id"]);
//
//      if(key.user_id == user_id) {
//          label = "unlike";
//      }
//     }
//     // return "like";
//     return new handlebars.SafeString('<button id="' + label + '-button" class="btn btn-danger" data-user_id="' + user_id + '"data-post_id="' + post_id + '">' + label + '</button>'
//     );
//
//
// });

$(function() {
  if (!$("#likes-template").length > 0) {
    // Wrong page.
    return;
  }

  let likestemplate = $($("#likes-template")[0]);
  let code = likestemplate.html();
  let tmpl = handlebars.compile(code);

  let showposts = $($("#post-likes")[0]);
  let path = showposts.data('path');
  let post_id = showposts.data('post_id');
  let current_user_id = showposts.data('current_user_id');

  let likebutton = $($("#like-button")[0]);
  let like_user_id = likebutton.data('user_id');
  let likebutton_post_id = likebutton.data('post_id');

  let unlikebutton = $($("#unlike-button")[0]);
  let unlike_user_id = unlikebutton.data('user_id');
  let unlikebutton_post_id = unlikebutton.data('post_id');

  function fetch_likes() {
    function got_likes(data) {
      console.log(data);
      let html = tmpl(data);
      showposts.html(html);
      window.location.reload();
    }

    $.ajax({
      url: path,
      data: {post_id: post_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  function add_like() {

    let data = {like: {post_id: likebutton_post_id, user_id: like_user_id}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes,
    });

    $("#post-like").val("");
    // $("#like-button").val("alsdfja");
  }

  function remove_like() {

    let data = {post_id: unlikebutton_post_id, user_id: unlike_user_id};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "DELETE",
      success: fetch_likes,
    });

    $("#post-like").val("");
  }

  likebutton.click(add_like);

  unlikebutton.click(remove_like);

  fetch_likes();
});
