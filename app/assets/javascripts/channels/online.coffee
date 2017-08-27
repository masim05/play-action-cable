name = Math.random().toString(36).substr(8)
App.onlineChannel = App.cable.subscriptions.create {channel: "OnlineChannel", name: name},
  connected: ->
    console.log 'connected'

  received: (data) ->
    console.log data, 'received'
