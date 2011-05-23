Dir["#{File.dirname(__FILE__)}/config/initializers/**/*.rb"].sort.each do |initializer|
  Kernel.load(initializer)
end

require 'redmine'
require 'redmetrics/scoreboard_menu_helper_patch'
require 'redmetrics/time_entry_patch'
require 'redmetrics/time_entry_reports_common_patch'
require 'redmetrics/user_patch'
require 'redmetrics/users_helper_patch'
require 'redmetrics/project_patch'

Redmine::Plugin.register :redmetricsplugin do
  name :'redmetrics.plugin_name'
  author 'Carlos Parra Camargo'
  description :'redmetrics.plugin_description'
  version '0.2'

  settings :default => { }

  requires_redmine :version_or_higher => '1.0.0'
  project_module :redmetricsplugin do
  #     permission :view_redmetrics, {:redmetrics => [:projects, :groups, :show]}
        permission :view_metrics, {:metrics => [:show]}
  end

  menu :project_menu, :metrics, {:controller => 'metrics', :action => 'show' }, :caption => :'redmetrics.caption_metrics', :after => :settings, :param => :project_id
  menu :top_menu, :redmetrics, {:controller => 'management', :action => 'projects'}, :caption => 'Redmetrics', :if => Proc.new { User.current.admin? }
  menu :scoreboard_menu, :projects, {:controller => 'management', :action => 'projects' }, :caption => :'redmetrics.caption_projects'
  menu :scoreboard_menu, :status, {:controller => 'management', :action => 'status' }, :caption => :'redmetrics.caption_status'
  menu :scoreboard_menu, :groups, {:controller => 'management', :action => 'groups' }, :caption => :'redmetrics.caption_groups'
  menu :admin_menu, :'redmetrics.label_cost_history', {:controller => 'admin', :action => 'cost_history'}, :html => {:class => 'issue_statuses'}, :caption => :'redmetrics.label_cost_history'
end
