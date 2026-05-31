class EquipmentController < ApplicationController
  def index
    @equipment = Equipment.includes(:category).all

    if params[:status].present?
      @equipment = @equipment.where(status: params[:status])
    end

    render json: @equipment
  end

  def show
    @item = Equipment.find(params[:id])
    render json: @item
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment item not found" }, status: :not_found
  end

  def create
    @item = Equipment.new(equipment_params)

    if @item.save
      render json: @item, status: :created
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @item = Equipment.find(params[:id])

    if @item.update(equipment_params)
      render json: @item
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment item not found" }, status: :not_found
  end

  def destroy
    @item = Equipment.find(params[:id])
    @item.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment item not found" }, status: :not_found
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
  end
end