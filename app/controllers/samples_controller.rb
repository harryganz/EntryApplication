class SamplesController < ApplicationController

  before_filter :authenticate_diver!
  load_and_authorize_resource

  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  # GET /samples
  # GET /samples.json
  def index
    if current_diver.role == 'admin'
      @samples = Sample.all
    elsif current_diver.role == 'manager'
      @samples = Sample.joins(:diver_samples).where( "diver_samples.diver_id=? AND diver_samples.primary_diver=? OR boatlog_manager_id=?", current_diver, true, current_diver.boatlog_manager_id ).uniq
    else
      @samples = current_diver.samples.merge(DiverSample.primary)
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @samples }
      format.csv  { send_data Sample.to_csv }
      format.xls
    end
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample }
    end
  end

  # GET /samples/new
  # GET /samples/new.json
  def new
    @sample = Sample.new

    2.times { @sample.diver_samples.build }
    @sample.sample_animals.build


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample }
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = Sample.find(params[:id])

  end
    
  # POST /samples
  # POST /samples.json
  def create
    @sample = Sample.new(params[:sample])

    respond_to do |format|
      if @sample.save
        format.html { redirect_to samples_path, notice: 'Sample was successfully created.' }
        format.json { render json: @sample, status: :created, location: @sample }
      else
        format.html { render action: "new" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.json
  def update
    @sample = Sample.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        format.html { redirect_to samples_path, notice: 'Sample was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.json
  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to samples_url }
      format.json { head :no_content }
    end
  end

  def proofing_template

    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample }
    end
  end
end
