class Admin::DashboardController < ApplicationController
  #before_filter :authorize
  layout 'admin'
  before_filter :require_admin
  
  def index
    @users=User.where(is_goaler: true)
  end

  def mentor_list
    @users=User.where(is_mentor: true)
    @muser=@users
  end

  def new_mentor
    
  end

  def create_mentor
    mentor = User.new(user_params) 
    if mentor.save!
      redirect_to admin_index_path 
    else
      render :text => 'failed'
    end
  end
  
  def show
  	#render :text => "<pre>"+params.to_yaml and return
  	@user=User.find(params[:id])
  	@goal=@user.goal
    @miles=@goal.milestones
    @mentor=User.find(@user.mentor_id) if @user.mentor_id.present? 
  end

  def edit
    # render :text => '<pre>' + params.to_yaml and return
  	@user=User.find(params[:id])
  end

  def update
    @user = User.find(params[:user][:id])
    if params[:user][:mentor_id].present?
      mentor = User.find(params[:user][:mentor_id])
      Goaler.send_mail_to_goaler(@user,mentor).deliver
    end
    if @user.update_attributes(user_params)
      redirect_to admin_index_path
    else
      redirect_to admin_dashboard_path
    end
  end
  
  def destroy
    @user = User.find(params[:format])
    @user.destroy
    redirect_to admin_index_path
  end

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:is_mentor,:mentor_id)
  end

end
