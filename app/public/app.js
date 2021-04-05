'use strict';

class Question extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      question: "..."
    };
  }

  componentDidMount() {
    var that = this;
    fetch('/today').then(res => res.json()).then(question => {
      that.setState({
        question: question.question
      });
    });
  }

  render() {
    return /*#__PURE__*/React.createElement("span", null, this.state.question);
  }

}

ReactDOM.render( /*#__PURE__*/React.createElement(Question, null), document.querySelector('#question'));