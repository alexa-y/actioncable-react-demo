React = require('react')
ReactDOM = require('react-dom')
DemoApp = require('./components/DemoApp.cjsx')

unless window.location.pathname.match(/^\/sign_in/)
  $(document).ready ->
    ReactDOM.render(<DemoApp cable={App.cable} />, document.getElementById('container'))
