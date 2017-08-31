import PropTypes from 'prop-types';
import React from 'react';

export default class Search extends React.Component {
  static propTypes = {
    onSearch: PropTypes.func.isRequired,
    searchState: PropTypes.string.isRequired,
    searchMessage: PropTypes.string.isRequired,
    results: PropTypes.arrayOf(PropTypes.object).isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {keywords: 'gwenpool'};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.status = this.status.bind(this);
  }

  handleChange(e) {
    this.setState({keywords: e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.onSearch(this.state.keywords);
  }

  render() {
    console.log('search props', this.props)
    return (
      <form onSubmit={this.handleSubmit}>
        <h2>Search</h2>
        <label>
          Keyword(s):
          <input type="text" value={this.state.keywords} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Search" />
        {this.status()}
        {this.props.results.map((result,i) => {
          return (
            <div key={i}>{result.title}</div>
          );
        })}
      </form>
    );
  }

  status() {
    if (this.props.searchState === 'failure') {
      return(
        <div>Error: {this.props.searchMessage}</div>
      )
    } else {
      return null;
    }

  }
}
