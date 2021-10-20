'use strict'

const app = new Vue({
  el: '#question',
  data: {
    question: "…",
    languages: { en: 'EN' },
    language: 'en',
  },
  methods: {
    loadToday: function() {
      return fetch('/today?lang=' + this.language).then(async (res) => {
        if ( res.status === 200 ) {
          const data = await res.json();
          this.question = data.question;
        } else {
          this.question = 'failure loading question';
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
      this.loadToday();
    }
  },
  beforeMount: function() {
    this.loadLangs();
    this.loadToday();
  }
});