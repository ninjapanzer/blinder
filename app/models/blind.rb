class Blind < ActiveRecord::Base
  belongs_to    :event
  acts_as_list  scope: :event
  has_many      :questions, -> { order("position DESC") }

  scope :by_level,    -> { unscoped.order(:level, :position) }
  scope :visible_for, -> (event) { event.blinds.where("level <= ?", event.blind_level) }

  attr_accessor :responses

  def new_responses_for(proposal)
    @responses = questions.map { |question| Response.new question: question, proposal: proposal }
  end

  def existing_responses_for(proposal)
    @responses = questions.map { |question| proposal.responses.where(question: question).first }
  end
end
