import PropTypes from 'prop-types';
import React from 'react';

import { BookPropTypes } from './constants';

export default class Loans extends React.Component {
  static propTypes = {
    loans: PropTypes.arrayOf(
      PropTypes.shape({
        type: PropTypes.string.isRequired,
        title: PropTypes.string.isRequired,
        due: PropTypes.string.isRequired,
        renewals: PropTypes.string.isRequired,
      })
    ).isRequired,
  };

  constructor(props) {
    super(props);
  }

  render() {
console.log(this.props)

    return (
      <div>
        <h4>Loans</h4>
        <table>
          <thead>
            <tr>
              <td>type</td>
              <td>title</td>
              <td>due</td>
              <td>renewals</td>
            </tr>
          </thead>
          <tbody>
            {this.props.loans.map((item, i) => {
              return (
                <tr key={i}>
                  <td>{item.type}</td>
                  <td>{item.title}</td>
                  <td>{item.due}</td>
                  <td>{item.renewals}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    );
  }
}
