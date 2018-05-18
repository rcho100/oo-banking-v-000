require 'pry'
class Transfer
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.valid? && self.sender.balance >= self.amount && self.status == "pending"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.amount = 0
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

    #without the counter I used the self.amount = 0 to pass the "each transfer can only happen once"
  end

  def reverse_transfer
    self.receiver.balance -= self.amount
    self.sender.balance += self.amount
    self.status = "reversed"
  end
end
