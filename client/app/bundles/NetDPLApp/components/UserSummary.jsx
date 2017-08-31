import PropTypes from 'prop-types';
import React from 'react';

export default class UserSummary extends React.Component {
  static propTypes = {
    email: PropTypes.string.isRequired,
  };

  constructor(props, _railsContext) {
    super(props);
  }

  render() {
    return (
      <div>
        <h3>
          Hello, {this.props.name}! ({this.props.email})
        </h3>
      </div>
    );
  }
}
