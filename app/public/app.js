'use strict'

var app = new Vue({
  el: '#question',
  data: {
    question: "..."
  }
});

fetch('/today').then((res) => res.json()).then((question) => {
  app.question = question.question;
});
