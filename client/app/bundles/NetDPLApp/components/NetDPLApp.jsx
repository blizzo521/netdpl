import PropTypes from 'prop-types';
import React from 'react';

import UserSummary from './UserSummary';
import Holds from './Holds';
import Books from './Books';
import Loans from './Loans';
import Search from './Search';
import { BookPropTypes } from './constants';
import * as Data from "./data";

export default class NetDPLApp extends React.Component {
  static propTypes = {
    user: PropTypes.shape({
      email: PropTypes.string.isRequired,
      name: PropTypes.string.isRequired,
    }).isRequired,
    loans: PropTypes.arrayOf(
      PropTypes.shape({
        type: PropTypes.string.isRequired,
        title: PropTypes.string.isRequired,
        due: PropTypes.string.isRequired,
        renewals: PropTypes.string.isRequired
      })
    ).isRequired,
    books: PropTypes.arrayOf(BookPropTypes).isRequired,
    holds: PropTypes.arrayOf(BookPropTypes).isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {
      email: this.props.user.email,
      name: this.props.user.name,
      holds: this.props.holds,
      books: this.props.books,
      loans: this.props.loans,
      results: [],
      searchState: '',
      searchMessage: '',
    };

    this.onSearch = this.onSearch.bind(this);
    this.onSearchSuccess = this.onSearchSuccess.bind(this);
    this.onSearchFailure = this.onSearchFailure.bind(this);
  }

  render() {
    return (
      <div>
        <UserSummary email={this.state.email} name={this.state.name} />
        <Loans loans={this.state.loans}/>
        <Holds holds={this.state.holds}/>
        <Books books={this.state.books}/>
        <hr />
        <Search onSearch={this.onSearch}
                searchState={this.state.searchState}
                searchMessage={this.state.searchMessage}
                results={this.state.results} />
      </div>
    );
  }

  onSearchSuccess(results) {
    this.setState({searchState: 'success', results: results, searchMessage: ''});
  }

  onSearchFailure(message) {
    this.setState({searchState: 'fail', results: [], searchMessage: message});
  }

  onSearch(keywords) {
    Data.searchResults(keywords, this.onSearchSuccess, this.onSearchFailure);
  }
}
