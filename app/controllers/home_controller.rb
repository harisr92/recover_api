class HomeController < ApplicationController
  before_action :find_platue
  FACE = {
    'N' => {
      'L' => 'W',
      'R' => 'E'
    },
    'S' => {
      'L' => 'E',
      'R' => 'W'
    },
    'E' => {
      'L' => 'N',
      'R' => 'S'
    },
    'W' => {
      'L' => 'S',
      'R' => 'N'
    }
  }.freeze

  def index
    if @platue
      render json: { state: @platue.states.pluck(:x, :y, :face).join(' ') }
    else
      render json: { message: 'No platue found' } && return
    end
  end

  def create
    init_platue
    update_rover
    state = @platue.states.pluck(:x, :y, :face).join(' ')
    message = 'You Hit The Wall' if @errors.messages.present?
    if @platue.errors.empty?
      render json: { state: state, plateau: @platue.id,
                     message: message || 'Success' }
    else
      render json: @platue.errors.messages
    end
  end

  def destroy
    @platue.try(:destroy)
    head :ok
  end

  private

  def platue_params
    platue_size = params[:plateau].split(' ')
    { width: platue_size.first, height: platue_size.first }
  end

  def state_params
    state_data = params[:state].split(' ')
    { x: state_data[0], y: state_data[1], face: state_data[2] }
  end

  def init_platue
    @platue = Platue.where(ip_addr: request.remote_ip).first_or_create
    @platue.update(platue_params) if params[:plateau].present?
    @platue.states.first_or_create.update(state_params)
  end

  def update_rover
    return if params[:move].empty?
    move_string = params[:move].split('')
    move_string.each do |pos|
      break if move(pos).present?
      rotate(pos)
    end
  end

  def rotate(pos)
    return unless %w[L R].include?(pos)
    state = @platue.states.first
    state.update(face: FACE[state.face][pos])
  end

  def move(pos)
    state = @platue.states.first
    return @error = state.errors unless pos == 'M'
    state.update(state.state_change[state.face])
    @errors = state.errors
  end

  def find_platue
    return unless params[:plateau_id].present?
    @platue = Platue.find_by(id: params[:plateau_id])
  end
end
