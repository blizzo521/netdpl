import PropTypes from 'prop-types';
import React from 'react';

export default class Search extends React.Component {
  static propTypes = {
    onSearch: PropTypes.func.isRequired,
    searchState: PropTypes.string.isRequired,
    searchMessage: PropTypes.string.isRequired,
    results: PropTypes.arrayOf(PropTypes.object).isRequired,
    results: PropTypes.arrayOf(
      PropTypes.shape({
        author: PropTypes.string.isRequired,
        available: PropTypes.string.isRequired,
        current_holds: PropTypes.string.isRequired,
        google_preview: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
        thumbnail_uri: PropTypes.string.isRequired,
      })
    ).isRequired,
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
        <table>
          <thead>
            <tr>
              <td>Image</td>
              <td>Title</td>
              <td>Author</td>
              <td>Available</td>
              <td>Curr. Holds</td>
              <td>Google Preview</td>
            </tr>
          </thead>
          <tbody>
            {this.props.results.map((result,i) => {
              return (
                <tr key={i}>
                  <td><img src={result.thumbnail_uri} /></td>
                  <td>{result.name}</td>
                  <td>{result.author}</td>
                  <td>{result.available}</td>
                  <td>{result.current_holds}</td>
                  <td><a href={result.google_preview}>Preview</a></td>
                </tr>
              );
            })}
          </tbody>
        </table>
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
