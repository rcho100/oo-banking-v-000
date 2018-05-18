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

  def old_amount= (self.amount)

  end
  def execute_transaction
    counter = 0
    if self.sender.valid? && self.sender.balance >= self.amount
      counter += 1
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.status = "complete"
    else
      counter += 1
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    binding.pry
    self.receiver.balance -= @@old_amount
    self.sender.balance += @@old_amount
    self.status = "reversed"
  end
end
