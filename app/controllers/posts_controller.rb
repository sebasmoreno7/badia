class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
        def index
      @posts = Post.all
        end
  
    # GET /burgers/1
    # GET /burgers/1.json
    def show
      @Post = Post.find(params[:id])
    end
  
    # GET /burgers/new
    def new
      @post = Post.new
    end
  
    # GET /burgers/1/edit
    def edit
      @post = Post.find(params[:id])
      if current_user != @post.user
        sign_out current_user
        redirect_to root_path
        flash[:notice] = "Unauthorized Request"
      end
    end
  
    # POST /burgers
    # POST /burgers.json
    def create
      @post = Post.new(post_params)
    @post.user_id = current_user.id
      if @post.save
        redirect_to @post
      flash[:notice] = "Event Created!"
      else
       redirect_back (fallback location: root_path)
       flash[:alert] = "Event Creation failed"
      end
    end
  
    # PATCH/PUT /burgers/1
    # PATCH/PUT /burgers/1.json
    def update
  
      @post = Post.find(params[:id])
        @post.update(post_params)
        if current_user == @post.user
        @post.update(post_params)
        redirect_to "/posts/#{@post.id}/edit"
        flash[:notice] = " Succesfully Updated"
        else
        redirect_back(fallback_location: root_path)
        flash[:alert] = "Not authorized to edit"
        end
    end
  
    # DELETE /burgers/1
    # DELETE /burgers/1.json
    def destroy
      post = Post.find(params[:id])
      if current_user == post.user
        post.destroy
        redirect_to "/posts"
        flash[:notice] = " Deleted"
      else
        redirect_back (fallback location: root_path)
        flash[:alert] = "Not authorized to delete"
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :user_id, :description, :image)
      end
  end