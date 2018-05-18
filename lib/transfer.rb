require 'pry'
class Transfer
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  @@old_amount = 0
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
    if self.sender.valid? && self.sender.balance >= self.amount
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      @@old_amount = self.amount
      self.amount = 0
      self.status = "complete"
    else
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
