React = require('react')

module.exports = Message = React.createClass
  propTypes:
    data: React.PropTypes.object.isRequired

  render: ->
    <div className="row">
      <div className="col-sm-12">
        <label>{@props.data.user} - {@props.data.created_at}</label>
        <p>{@props.data.body}</p>
      </div>
    </div>
