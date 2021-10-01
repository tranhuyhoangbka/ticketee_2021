class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    @tag = @ticket.tags.find(params[:id])
    @ticket.tags.destroy(@tag)
    head :ok
  end
end
