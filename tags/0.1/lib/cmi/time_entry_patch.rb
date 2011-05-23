require_dependency 'time_entry'
require 'dispatcher'

# Patches Redmine's TimeEntry dinamically. Adds callbacks to save the role and
# cost added by the plugin.
module CMI
  module TimeEntryPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable # Send unloadable so it will be reloaded in development
        before_save :update_role_and_cost
        before_validation_on_create :initialize_role
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def initialize_role
        self.role = User.current.role
      end

      def update_role_and_cost
        @hash_cost_actual_year = (HistoryProfilesCost.find :all).group_by(&:year)[Date.today.year].group_by(&:profile)
        user_role = self.role.nil? ? (!User.current.role.blank? ? User.current.role : "") : self.role
        if attribute_present?("hours") and !user_role.blank?
          self.role = User.current.role if self.role.nil? and !User.current.role.blank?
          self.cost = (self.hours.to_f * @hash_cost_actual_year["#{self.role}"].first.value.to_f)
        end
      end
    end
  end
end

Dispatcher.to_prepare do
  TimeEntry.send(:include, CMI::TimeEntryPatch)
end
