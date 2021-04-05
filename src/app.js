'use strict';

class Question extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      question: "...",
    }
  }

  componentDidMount() {
    var that = this;
    fetch('/today')
      .then((res) => res.json())
      .then((question) => {
        that.setState({ question: question.question });
      });
  }

  render() {
    return (<span>{this.state.question}</span>);
  }
}

ReactDOM.render(<Question />, document.querySelector('#question'));