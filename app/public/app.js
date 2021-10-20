'use strict'

const app = new Vue({
  el: '#question',
  data: {
    question: "…",
    id: 0,
    languages: { en: 'EN' },
    language: 'en',
  },

  methods: {
    loadQuestion: function() {
      var uri = '/';
      if ( this.id === 0 ) {
        uri = '/today';
      } else {
        uri = '/!/' + this.id;
      }

      return fetch(uri + '?lang=' + this.language).then(async (res) => {
        if ( res.status === 200 ) {
          const data = await res.json();
          this.question = data.question;
          this.id = Number.parseInt(data.id);
        } else {
          if ( this.id === 0 ) {
            this.question = 'failure loading question';
          } else {
            // you've reached the end of the internet. hold perfectly still.
            this.id--;
          }
        }
      });
    },
    loadLangs: function() {
      return fetch('/languages').then(async (res) => {
        if ( res.status === 200 ) {
          const data = await res.json();
          this.languages = data.languages;
          this.language = data.language;
        }
      });
    },
    switchLanguage: function(lang) {
      this.language = lang;
      this.loadQuestion();
    },
    back: function() {
      var id = this.id - 1;
      if ( id <= 0 ) id = 1;
      this.id = id;

      this.loadQuestion();
    },
    forward: function() {
      this.id++;
      this.loadQuestion();
    }
  },

  beforeMount: function() {
    this.loadLangs();
    this.loadQuestion();
  }
});