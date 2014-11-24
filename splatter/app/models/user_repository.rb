 class UserRepository
  BUCKET = 'users'
  
  #sets up our connection to the Riak db
  def initialize(client)
   @client = client
  end
  
  def all
    users = @client.bucket(BUCKET)
    @all_users = []
    keys = users.keys
     if keys
       keys.each do | key | 
        @all_users << find(key)
       end
     end
    @all_users
  end
  
  def delete(user)
    users = @client.bucket(BUCKET)
    users.delete(user.email) 
  end
  
  def find(key)
    riak_obj = @client.bucket(BUCKET)[key]
    user = User.new
    user.email = riak_obj.data['email']
    user.name = riak_obj.data['name']
    user.password = riak_obj.data['password']
    user.blurb = riak_obj.data['blurb']
    user.follows = riak_obj.data['follows']
    user.followers = riak_obj.data['followers']
    user
  end
  
  def save(user)
    users = @client.bucket(BUCKET)
    key = user.email
    
    unless users.exists?(key)
     riak_obj = users.new(key)
     riak_obj.data = user
     riak_obj.content_type = 'application/json'
     riak_obj.store
    end
  end
  
  def update(user)
   users = @client.bucket(BUCKET)
   key = user.email
   
   riak_obj = users[key]
   riak_obj.data = user
   riak_obj.store  
  end

  def show
   db = UserRepository.new(Riak::Client.new)
   @user = db.find(params[:id])
   render json: @user
  end
  
  def follow(follower, followed)
		if follower.follows
			follower.follows << followed.email
		else
			follower.follows = [followed.email]
		end
		if followed.followers
			followed.followers << follower.email
		else
			followed.followers = [follower.email]
		end
		update(followed)
		update(follower)
  end
  
	 def unfollow(follower, followed)
		follower.follows.delete(followed.email)
		followed.followers.delete(follower.email)
		update(followed)
		update(follower)
     end
  
  def show_follows(user)
	@follows = []
	user.follows.each do | email | 
	@follows << find(email)
	end
	@follows
  end
  
  def show_follower(user)
	@follows = []
	user.followers.each do | email | 
	@follows << find(email)
	end
	@follows
  end
  
 end

