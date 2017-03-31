class LikesController < ApplicationController
  def index
    @likes = Like.all

    render("likes/index.html.erb")
  end

  def show
    @like = Like.find(params[:id])

    render("likes/show.html.erb")
  end

  def new
    @like = Like.new

    render("likes/new.html.erb")
  end

  def create
    @like = Like.new

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/likes/new", "/create_like"
        redirect_to("/likes")
      else
        redirect_back(:fallback_location => "/", :notice => "Like created successfully.")
      end
    else
      render("likes/new.html.erb")
    end
  end

  def edit
    @like = Like.find(params[:id])

    render("likes/edit.html.erb")
  end

  def update
    @like = Like.find(params[:id])

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/likes/#{@like.id}/edit", "/update_like"
        redirect_to("/likes/#{@like.id}", :notice => "Like updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Like updated successfully.")
      end
    else
      render("likes/edit.html.erb")
    end
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    if URI(request.referer).path == "/likes/#{@like.id}"
      redirect_to("/", :notice => "Like deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Like deleted.")
    end
  end
end
