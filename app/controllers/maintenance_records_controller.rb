class MaintenanceRecordsController < ApplicationController
  before_action :set_maintenance_record, only: [:show, :update, :destroy]

  # GET /maintenance_records
  # Requirement: Order by performed_at DESC, implement query filter, optimize with .includes
  def index
    @maintenance_records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc)
    
    if params[:equipment_id].present?
      @maintenance_records = @maintenance_records.where(equipment_id: params[:equipment_id])
    end

    render json: @maintenance_records.as_json(include: { equipment: { only: :name } })
  end

  # GET /maintenance_records/:id
  def show
    render json: @maintenance_record.as_json(include: { equipment: { only: :name } })
  end

  # POST /maintenance_records
  # Requirement: Return 201 Created on success
  def create
    @maintenance_record = MaintenanceRecord.new(maintenance_record_params)
    if @maintenance_record.save
      render json: @maintenance_record, status: :created
    else
      render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /maintenance_records/:id
  def update
    if @maintenance_record.update(maintenance_record_params)
      render json: @maintenance_record, status: :ok
    else
      render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /maintenance_records/:id
  # Requirement: Return 204 No Content on success
  def destroy
    @maintenance_record.destroy
    head :no_content
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance record not found" }, status: :not_found
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
  end
end
