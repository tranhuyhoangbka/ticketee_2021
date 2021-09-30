class Admin::StatesController < Admin::ApplicationController
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new state_params
    if @state.save
      redirect_to admin_states_path, notice: 'State has been created.'
    else
      flash.now[:alert] = "state has not been created."
      render :new
    end
  end

  def make_default
    @state = State.find(params[:id])
    State.update_all default: false
    @state.update default: true
    redirect_to admin_states_path, notice: "#{@state.name} is now the default state."
  end

  private
  def state_params
    params.require(:state).permit(:name, :color)
  end
end
