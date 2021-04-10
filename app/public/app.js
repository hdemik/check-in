'use strict'

const app = new Vue({
  el: '#question',
  data: {
    question: "..."
  },
  methods: {
    loadToday: function() {
      return fetch('/today').then(async (res) => {
        if ( res.status === 200 ) {
          const data = await res.json();
          this.question = data.question;
        } else {
          this.question = 'failure loading question';
        }
      });
    }
  },
  beforeMount: function() {
    this.loadToday();
  }
});