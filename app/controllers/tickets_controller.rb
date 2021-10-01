class TicketsController < ApplicationController
  before_action :authenticate_user!, except: %i(show)
  before_action :set_project
  before_action :set_ticket, only: %i(show edit update destroy watch)

  def show
    @comments = @ticket.comments.ordered
    @comment = @ticket.comments.build(state: @ticket.state)
    @states = State.all
  end

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    if params[:attachments].present?
      @ticket.attachments.attach(params[:attachments])
    end
    if @ticket.save
      redirect_to [@project, @ticket], notice: 'Ticket has been created.'
    else
      flash.now[:alert] = 'Ticket has not been created.'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:attachments].present?
      @ticket.attachments.attach(params[:attachments])
    end
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], notice: 'Ticket has been updated.'
    else
      flash.now[:alert] = 'ticket has not been updated'
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to @project, notice: 'Ticket has been deleted.'
  end

  def upload_file
    blob = ActiveStorage::Blob.create_and_upload!(io: params[:file], filename: params[:file].original_filename)
    render json: { signedId: blob.signed_id }
  end

  def watch
    if @ticket.watchers.exists?(current_user.id)
      @ticket.watchers.destroy(current_user)
      flash[:notice] = 'You are no longer watching this ticket.'
    else
      @ticket.watchers << current_user
      flash[:notice] = 'You are now watching this ticket.'
    end
    redirect_to [@project, @ticket]
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description, attachments: [])
  end
end
