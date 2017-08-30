import PropTypes from 'prop-types';
import React from 'react';

import { BookPropTypes } from './constants';

export default class Loans extends React.Component {
  static propTypes = {
    loans: PropTypes.arrayOf(BookPropTypes).isRequired,
  };

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <h4>Loans</h4>
        {this.props.loans.map((item, i) => {
          return (<div key={item.id}>ID: {item.id}</div>);
        })}
      </div>
    );
  }
}
