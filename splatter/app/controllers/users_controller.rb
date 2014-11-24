 class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
   db = UserRepository.new(Riak::Client.new) 
   @users = db.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    db = UserRepository.new(Riak::Client.new)
    @user = db.find(params[:id])

    render json: @user
  end
  
  # POST /users
  # POST /users.json
  def create
    db  = UserRepository.new(Riak::Client.new)
    @user = User.new
    @user.email = params[:email]
    @user.name = params[:name]
    @user.password = params[:password]
    @user.blurb = params[:blurb]

    if db.save(@user)
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    db = UserRepository.new(Riak::Client.new)
   
    @user = db.find(params[:id])

    if params[:name]
      @user.name = params[:name]
    end

    if params[:password]
      @user.passowrd = params[:password]
    end

    if params[:blurb]
      @user.blurb = params[:blurb]
    end

    if db.update(@user)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    db = UserRepository.new(Riak::Client.new)
    @user = db.find(params[:id])
    db.delete(@user)
    head :no_content
  end
  
  def splatts
	db = UserRepository.new(Riak::Client.new)
	@user = db.find(params[:id])
	db = SplattRepository.new(Riak::Client.new, @user)
	render json: db.all
  end
  
  # GET /users/follows/1
  # GET /users/follows/1.json
  def show_follows
  db = UserRepository.new(Riak::Client.new)
  @user = db.find(params[:id])
  render json: db.show_follows(@user)
  end

  # GET /users/followers/1
  # GET /users/followers/1.json
  def show_followers
  db = UserRepository.new(Riak::Client.new)
  @user = db.find(params[:id])
  render json: db.show_followers(@user)
  end
  
  #if user wants to follow someone
	  # POST /users/follows
def add_follows
	db = UserRepository.new(Riak::Client.new)
	@follower = db.find(params[:id])
	@followed = db.find(params[:follows_id])
	if db.follow(@follower, @followed)
	head :no_content
	else
	render json: "error saving follow relationship" , status: :unprocessable_entity
	end
end

  
  #delete user
  def delete_follows
	  db = UserRepository.new(Riak::Client.new)
	  @follower = db.find(params[:id])
	  @followed = db.find(params[:follows_id])
	  if db.unfollow(@follower, @followed)
	  head :no_content
	  else
	  render json: @follower.errors, status: :unprocessable_entity
	  end
  end

  def splatts_feed
	@feed = Splatt.find_by_sql("SELECT * FROM splatts JOIN follows ON follows.followed_id = splatts.user_id
							WHERE follows.follower_id = #{params[:id]} ORDER BY created_at DESC")
	render json: @feed
  end
  
  private
  def user_params(params)
  params.permit(:email, :password, :name, :blurb)
  end
  
  #method applies the set_headers method before performing other methods
  def set_headers
  headers['Access-Control-Allow-Origin'] = '*'
  end
  
end
