class Api::BuildingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:index]
  
  def index
    buildings = Building.includes(:client, :custom_field_values)  # Removed pagination
    render json: {
      status: "success",
      buildings: buildings.map do |building|
        {
          id: building.id,
          client_name: building.client.name,
          address: building.address,
          custom_fields: building.custom_field_values.map do |field|
            { field.custom_field_configuration.field_name => field.value }
          end.reduce({}, :merge)
        }
      end
    }
  end

  def create
    building = Building.new(building_params)

    if building.save
      render json: { status: "success", message: "Building created!" }, status: :created
    else
      render json: { status: "error", errors: building.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    building = Building.find_by(id: params[:id])

    if building.nil?
      render json: { status: "error", message: "Building not found" }, status: :not_found
      return
    end

    if building.update(building_params)
      render json: { status: "success", message: "Building updated!" }
    else
      render json: { status: "error", errors: building.errors.full_messages }
    end
  end

  private

  def building_params
    params.require(:building).permit(
      :client_id, :address, :state, :zip,
      custom_field_values_attributes: [:custom_field_configuration_id, :value]
    )
  end
end
