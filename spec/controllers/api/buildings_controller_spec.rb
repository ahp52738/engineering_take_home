require 'rails_helper'

RSpec.describe Api::BuildingsController, type: :controller do
  let!(:client) { Client.create!(name: "Test Client") }
  let!(:custom_field_configuration) { client.custom_field_configurations.create!(field_name: "Custom Field 1", field_type: 1) }
  let!(:building) { client.buildings.create!(address: "123 Main St", state: "NY", zip: "10001") }
  let!(:custom_field_value) { building.custom_field_values.create!(custom_field_configuration_id: custom_field_configuration.id, value: "Test Value") }

  describe "GET #index" do
    it "returns a list of buildings" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)["buildings"]).to be_an Array
      expect(JSON.parse(response.body)["buildings"].first["address"]).to eq("123 Main St")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_building_params) do
        { 
          building: { 
            client_id: Client.first.id,
            address: "456 Elm St", 
            state: "CA", 
            zip: "90001", 
            custom_field_values_attributes: [
              { custom_field_configuration_id: custom_field_configuration.id, value: "Some Value", client_id: Client.first.id }
            ] 
          }
        }
      end

      it "creates a new building" do
        post :create, params: valid_building_params
        puts building.last.errors.full_messages unless response.status == 201
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["message"]).to eq("Building created!")
        expect(client.buildings.count).to eq(2)
      end
    end

    context "with invalid params" do
      let(:invalid_building_params) { { building: { address: "" } } }

      it "returns an error if building creation fails" do
        post :create, params: invalid_building_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).to include("Address can't be blank")
      end
    end
  end

  describe "PUT #update" do
    let(:update_params) { { building: { address: "789 Oak St", state: "TX", zip: "75001" } } }

    it "updates an existing building" do
      put :update, params: { id: building.id, building: update_params[:building] }

      building.reload
      expect(response).to have_http_status(:success)
      expect(building.address).to eq("789 Oak St")
    end

    it "returns an error if building not found" do
      put :update, params: { id: 999999, building: { address: "Nonexistent Address" } }

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq("Building not found")
    end
  end
end