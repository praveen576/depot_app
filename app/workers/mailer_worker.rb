class MailerWorker

  include Sidekiq::Worker
  
  def perform(order_id)
    order = Order.find_by_id(order_id)
    OrderNotifier.received(order).deliver
  end
end
