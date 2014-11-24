class SplattsController < ApplicationController
  # GET /splatts
  # GET /splatts.json
  def index
    db = UserRepository.new(Riak::Client.new)
	@users = db.all
	@splatts = []
	@users.each do | user | 
	db = SplattRepository.new(Riak::Client.new, user)
	@splatts.concat(db.all)
	end
	render json: @splatts
  end

  # GET /splatts/1
  # GET /splatts/1.json
  def show
   db = UserRepository.new(Riak::Client.new)
   user = db.find(params[:user_id])
   db = SplattRepository.new(Riak::Client.new, user)
   @splatt = db.find(params[:id])
   render json: @splatts
  end

  # POST /splatts
  # POST /splatts.json
  def create
    db = UserRepository.new(Riak::Client.new)
    user = db.find(params[:user_id])
	db = SplattRepository.new(Riak::Client.new, user)
	
	@splatt = Splatt.new
	@splatt.body = params[:body]
	@splatt.created_at = Time.now
	@splatt.id = SecureRandom.uuid
	
    if db.save(@splatt)
      render json: @splatt, status: :created, location: @splatt
    else
      render json: @splatt.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /splatts/1
  # PATCH/PUT /splatts/1.json
  def update
    db = UserRepository.new(Riak::Client.new)
    user = db.find(params[:user_id])
	db = SplattRepository.new(Riak::Client.new, user)
	@splatt = db.find(params[:id])

	if params[:body]
		@splatt.body = params[:body]
	end
    if db.update(@splatt)
      head :no_content
    else
      render json: @splatt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /splatts/1
  # DELETE /splatts/1.json
  def destroy
    db = UserRepository.new(Riak::Client.new)
    user = db.find(params[:user_id])
	db = SplattRepository.new(Riak::Client.new, user)
	db.delete(params[:id])
    head :no_content
  end
  
  private
  def splatts_params(params)
   params.permit(:body, :user_id)
  end
end
