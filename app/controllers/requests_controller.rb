class RequestsController < ApplicationController
  before_action :set_request, only: [:show]

  # GET /requests
  def index
    @requests = Request.all

    render json: @requests.map { |r| serialize(r) }
  end

  # GET /requests/1
  def show
    render json: serialize(@request)
  end

  # POST /requests
  def create
    @request = Request.new(params.permit(:url))

    unless @request.save
      render json: @request.errors, status: :unprocessable_entity
      return
    end

    ProcessRequestJob.perform_later(@request.id)

    render json: @request, status: :created, location: @request
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  def serialize(request)
    data = request.result&.data || {}

    request.as_json.merge(data: data)
  end
end
