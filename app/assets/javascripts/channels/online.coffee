window.addEventListener "load", () ->
  name = Math.random().toString(36).substr(8)
  div = document.getElementById "name"
  div.innerHTML = name

  list = document.getElementById "list"

  App.onlineChannel = App.cable.subscriptions.create {channel: "OnlineChannel", name: name},
    connected: ->

    received: (data) ->
      switch data.action
        when 'subscribe'
          es = document.querySelectorAll("[data-name='#{data.name}']")
          break if es.length

          li = document.createElement "li"
          li.setAttribute('data-name', data.name)
          li.appendChild document.createTextNode(data.name)
          list.appendChild(li)

        when 'unsubscribe'
          es = document.querySelectorAll("[data-name='#{data.name}']")
          for e in es
            list.removeChild e



