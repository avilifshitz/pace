class UserController < ApplicationController
  layout 'theme'
  before_filter :authenticate_user!, only: [:dashboard]
  def show
    @message=Conversation.find(params[:id])
    if current_user.is_mentor?
      @users = User.where(:mentor_id => current_user.id)

    else
      @mentor = User.find(current_user.mentor_id)
    end
  end
  
  def goals
  	session[:goal_title]=params[:title]
  	session[:goal_from]=params[:from]
  	session[:goal_to]=params[:to]
  	redirect_to milestone_path
  end
  
  def miles
    
  	session[:miles_title]=params[:title]
  	session[:miles_from]=params[:from]
  	session[:miles_to]=params[:to]
  	redirect_to new_user_registration_path
  
  end

  def create_miles
    @mile=Milestone.new(miles_params)
    if @mile.save
      redirect_to dashboard_path
      flash[:notice] = "You have successfully Added Your Milestone."
    else
      redirect_to dashboard_path
    end
  end
  

  def edit_miles
    @miles=Milestone.find(params[:format])
  end  

  def update_miles
    @miles = Milestone.find(params[:milestone][:id])
 
      if @miles.update_attributes(miles_params)
        redirect_to dashboard_path
      else
          redirect_to dashboard_path
      end
    
  end

  def destroy_miles
    @miles = Milestone.find(params[:format])
    @miles.destroy
   
    redirect_to dashboard_path
  end

  def dashboard
    @user=current_user if current_user.present? 
    @goal=@user.goal
    @miles=@goal.milestones if @goal
    @mentor=User.find(@user.mentor_id) if @user.mentor_id.present?
  end

  def miles_params
    params.require(:milestone).permit(:to,:from,:goal_id,:title)
  end

  def inbox
    inbox = current_user.mailbox.inbox if current_user
    inbox.each do |i|
      @recieved = i.messages
    end
  end

  def sent_box
    sent_box = current_user.mailbox.sentbox if current_user
    sent_box.each do |i|
      @sent = i.messages
    end
  end

end
