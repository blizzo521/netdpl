import PropTypes from 'prop-types';
import React from 'react';

import { BookPropTypes } from './constants';

export default class Holds extends React.Component {
  static propTypes = {
    holds: PropTypes.arrayOf(BookPropTypes).isRequired,
  };

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <h4>Holds</h4>
        {this.props.holds.map((item, i) => {
          return (<div key={item.id}>ID: {item.id}</div>);
        })}
      </div>
    );
  }
}
