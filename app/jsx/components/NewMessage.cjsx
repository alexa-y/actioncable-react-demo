React = require('react')

module.exports = NewMessage = React.createClass
  propTypes:
    onSend: React.PropTypes.func.isRequired

  render: ->
    <div className="footer">
      <div className="row">
        <div className="col-sm-12">
          <input className="form-control" placeholder="Enter a message" onKeyDown={@keyDown}/>
        </div>
      </div>
    </div>

  keyDown: (e) ->
    if e.which == 13
      @props.onSend(e.target.value)
      e.target.value = ''
