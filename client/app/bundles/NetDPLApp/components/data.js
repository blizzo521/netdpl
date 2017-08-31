import ReactOnRails from 'react-on-rails';

export const searchResults = (keywords, successFn, failureFn) => {
  console.log('go get results for ', keywords)

  fetch('/search?keywords='+encodeURI(keywords), {
    method: 'GET',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      'Accepts': 'application/json',
      'X-CSRF-Token': ReactOnRails.authenticityToken(),
    }
  })
    .then(
      function(response) {
        if (response.status !== 200) {
          failureFn('Looks like there was a problem. Status Code: ' + response.status);
          return;
        }
        response.json().then(function(data) {
          console.log('data', data);
          successFn(data);
        });
      }
    )
    .catch(function(err) {
      failureFn(err);
    });
}
