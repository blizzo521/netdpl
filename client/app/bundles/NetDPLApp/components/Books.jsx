import PropTypes from 'prop-types';
import React from 'react';

import { BookPropTypes } from './constants';

export default class Books extends React.Component {
  static propTypes = {
    books: PropTypes.arrayOf(BookPropTypes).isRequired,
  };

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <h4>Books</h4>
        {this.props.books.map((item, i) => {
          return (<div key={item.id}>ID: {item.id}</div>);
        })}
      </div>
    );
  }
}
