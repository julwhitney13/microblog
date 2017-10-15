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

import socket from "./socket"

let handlebars = require("handlebars");

handlebars.registerHelper('num_likes', function(json) {
    return Object.keys(json).length;
});

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

  function update_like_status(button, remove, add, text) {
    button.removeClass(remove);
    button.addClass(add);
    button.addClass("hidden-xl-down")
    button.text(text);
  }

  function add_like() {

    let data = {like: {post_id: likebutton_post_id, user_id: like_user_id}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: function(msg) {
          fetch_likes();
          likebutton.css("display","none");
          unlikebutton.css("display","inline-block");
      }
    });

    $("#like-button").val("");
  }

  function remove_like() {

    let data = {post_id: unlikebutton_post_id, user_id: unlike_user_id};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "DELETE",
      success: function(msg) {
          fetch_likes();
          unlikebutton.css("display","none");
          likebutton.css("display","inline-block");
      }
    });

    $("#unlike-button").val("");
  }

  likebutton.click(add_like);

  unlikebutton.click(remove_like);

  fetch_likes();
});
