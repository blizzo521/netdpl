import PropTypes from 'prop-types';
import React from 'react';

import UserSummary from './UserSummary';
import Holds from './Holds';
import Books from './Books';
import Loans from './Loans';
import { BookPropTypes } from './constants';

export default class NetDPLApp extends React.Component {
  static propTypes = {
    user: PropTypes.shape({
      email: PropTypes.string.isRequired,
      name: PropTypes.string.isRequired,
    }).isRequired,
    holds: PropTypes.arrayOf(BookPropTypes).isRequired,
    books: PropTypes.arrayOf(BookPropTypes).isRequired,
    loans: PropTypes.arrayOf(BookPropTypes).isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {
      email: this.props.user.email,
      name: this.props.user.name,
      holds: this.props.holds,
      books: this.props.books,
      loans: this.props.loans,
    };
  }

  render() {
    return (
      <div>
        <UserSummary email={this.state.email} name={this.state.name} />
        <Loans loans={this.state.loans}/>
        <Holds holds={this.state.holds}/>
        <Books books={this.state.books}/>
      </div>
    );
  }
}
