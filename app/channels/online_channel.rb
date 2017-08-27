class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_for("all")

    @@subscriptions ||= []
    @@subscriptions += [params[:name]]

    puts '@@subscriptions', @@subscriptions

    notify_subscribed(@@subscriptions)
  end

  def unsubscribed
    @@subscriptions -= [params[:name]]
    notify_unsubscribed(name: params[:name])
  end

  private

  def notify_subscribed(subscriptions)
    subscriptions.each {|s| notify(:subscribe, {name: s})}

  end

  def notify_unsubscribed(data)
    notify(:unsubscribe, data)
  end

  def notify(event, data)
    OnlineChannel.broadcast_to(
      "all",
      data.merge(action: event)
    )
  end
end