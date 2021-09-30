class CommentsController < ApplicationController
  before_action :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to [@ticket.project, @ticket], notice: 'Comment has been created.'
    else
      flash.now[:alert] = 'Comment has not been created.'
      @project = @ticket.project
      @states = State.all
      render 'tickets/show'
    end
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id)
  end
end
