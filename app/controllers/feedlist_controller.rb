class FeedlistController < ApplicationController

  helper :feedlist

  def index
    @page_title = 'TRACKS::Feeds'
    
    unless mobile?
      init_data_for_sidebar 
    else
      @projects = current_user.projects
      @contexts = current_user.contexts
    end
    
    @active_projects = current_user.projects.active
    @hidden_projects = current_user.projects.hidden
    @completed_projects = current_user.projects.completed
    
    @active_contexts = current_user.contexts.active
    @hidden_contexts = current_user.contexts.hidden
    
    respond_to do |format|
      format.html { render :layout => 'standard' }
      format.m { render :action => 'mobile_index' }
    end
  end
  
  def get_feeds_for_context
    context = current_user.contexts.find params[:context_id]
    render :partial => 'feed_for_context', :locals => { :context => context }
  end

  def get_feeds_for_project
    project = current_user.projects.find params[:project_id]
    render :partial => 'feed_for_project', :locals => { :project => project }
  end

end
