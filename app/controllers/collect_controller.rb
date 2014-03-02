class CollectController < ApplicationController
  def home
    @event = Event.first
  end

  def new
    @event = Event.includes(blinds: :questions).find(params[:event_id])
    @proposal = Proposal.new

    #generate the response models we'll need for the form
    @event.blinds.map { |blind| blind.new_responses_for @proposal }
  end
end
