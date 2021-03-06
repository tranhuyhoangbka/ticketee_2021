class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      comment_notifier = CommentNotifier.new(@comment)
      comment_notifier.notify_watchers
      unless @ticket.watchers.exists?(current_user.id)
        @ticket.watchers << current_user
      end
      redirect_to [@ticket.project, @ticket], notice: 'Comment has been created.'
    else
      flash.now[:alert] = 'Comment has not been created.'
      @project = @ticket.project
      @states = State.all
      @comments = @ticket.comments.ordered
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
