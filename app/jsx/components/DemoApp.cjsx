React = require('react')
Message = require('./Message.cjsx')
NewMessage = require('./NewMessage.cjsx')

module.exports = DemoApp = React.createClass
  propTypes:
    cable: React.PropTypes.object.isRequired

  getInitialState: ->
    { messages: [], channel: undefined, loading: true }

  componentDidMount: ->
    @retrieveBacklog()

  render: ->
    return <h1>Loading...</h1> if @state.loading
    <div>
      <div className="messages">
        {@state.messages.map (message) ->
          <Message data={message} key={"#{message.user}_#{message.created_at}"} />}
      </div>
      <NewMessage onSend={@sendMessage} />
    </div>

  retrieveBacklog: ->
    resp = $.getJSON '/messages', (data) =>
      messages = @state.messages.concat(data)
      @setState({ messages: messages.sort (a, b) -> new Date(a.created_at) - new Date(b.created_at) })

    resp.done =>
      @subscribeTo('MessagesChannel')

  subscribeTo: (channelName) ->
    channel = @props.cable.subscriptions.create { channel: channelName },
      received: @dataReceived

    @setState({ channel: channel })

  dataReceived: (data) ->
    if data.method == 'user_status' && data.user == ENV.current_user
      console.log(data)
      @setState({ loading: false })
    if data.method == 'message'
      return if @state.messages.some (message) -> data.message.user == message.user && data.message.created_at == message.created_at
      messages = @state.messages
      messages.push(data.message)
      @setState({ messages: messages.sort (a, b) -> new Date(a.created_at) - new Date(b.created_at) })

  sendMessage: (message) ->
    @state.channel.send({ method: 'sent_message', message: message })
