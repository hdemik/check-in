'use strict';

const e = React.createElement;

class Question extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return e("span", {}, "Hello World!");
  }
}

const domContainer = document.querySelector('#question');
ReactDOM.render(e(Question), domContainer);