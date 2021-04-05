import React from 'react';
import Question from 'app';
import jasmineEnzyme from 'jasmine-enzyme';

describe('app', () => {
  var wrapper;

  beforeEach(() => {
    jasmineEnzyme();
    wrapper = mount(<Question />); // mount/render/shallow when applicable
  });

  it('renders without crashing', () => {
    expect(wrapper.find('#disabled')).toBeDisabled();
    expect(wrapper.find('#not')).not.toBeDisabled();
  });
});