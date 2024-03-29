module Redmetrics
  module Loaders
    module CreateData
      include Redmine::I18n

      class << self
        # Loads the redmetrics needed trackers, issue statuses, issue priorities and custom fields
        def load
          # Trackers
          DEFAULT_VALUES['trackers'].each do |tracker, name|
            Tracker.create(:name => name, :is_in_chlog => true,  :is_in_roadmap => true)
          end

          # Issue statuses
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['new'], :is_closed => false, :is_default => true)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['in_progress'], :is_closed => false, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['resolved'], :is_closed => false, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['feedback'], :is_closed => false, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['closed'], :is_closed => true, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['rejected'], :is_closed => true, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['accepted'], :is_closed => false, :is_default => false)
          IssueStatus.create(:name => DEFAULT_VALUES['issue_status']['approval'], :is_closed => false, :is_default => false)

          # Enumerations
          (DEFAULT_VALUES['risk_levels'].values.flatten |
           DEFAULT_VALUES['incidence_levels'].values.flatten).each do |priority|
            IssuePriority.create(:name => priority)
          end

                  # IssueCustomField
          tracker = Tracker.find_by_name(DEFAULT_VALUES['trackers']['report'])
          list = []
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'JP'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'AF'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'AP'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'PS'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'PJ'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['current']).gsub('{{profile}}', 'B'),
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['report_material_original_budget_field'], :field_format => "float",
                  :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true, :is_filter => false,
                  :searchable => false, :editable => true, :default_value => 0)

          list << IssueCustomField.create(:type => "IssueCustomField",
                  :name => DEFAULT_VALUES['report_material_current_budget_field'], :field_format => "float",
                  :possible_values => [], :regexp => "", :is_required => false, :is_for_all => true, :is_filter => false,
                  :searchable => false, :editable => true, :default_value => 0)
          list << IssueCustomField.create(:type => "IssueCustomField", :name => DEFAULT_VALUES['expense_value_field'],
                  :field_format => "float", :possible_values => [], :regexp => "", :is_required => false, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => 0)

          list << IssueCustomField.create(:type => "IssueCustomField", :name => DEFAULT_VALUES['spected_date_end'],
                  :field_format => "date", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => nil)

          list << IssueCustomField.create(:type => "IssueCustomField", :name => DEFAULT_VALUES['quality_meets_done'],
                  :field_format => "int", :possible_values => [], :regexp => "", :is_required => false, :is_for_all => true,
                  :is_filter => false, :searchable => false, :editable => true, :default_value => "")

          list.each do |icf|
            unless icf.new_record? # not saved
              icf.trackers[0] = tracker
              tracker.custom_fields << icf
              tracker.save
              icf.save
            end
          end

          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['budget_spected_rrmm'],
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true,
            :is_for_all => false, :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['budget_accepted'],
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true,
            :is_for_all => false, :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'JP'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'AF'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'AP'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'PS'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'PJ'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)
          ProjectCustomField.create(:type => "ProjectCustomField",
            :name => DEFAULT_VALUES['effort'].gsub('{{type}}', DEFAULT_VALUES['spected']).gsub('{{profile}}', 'B'),
            :field_format => "float", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true, :default_value => 0)

          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['date_start_real'],
            :field_format => "date", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true)
          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['date_start_planned'],
            :field_format => "date", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true)
          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['date_end_planned'],
            :field_format => "date", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true)

          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['quality_meets_planned'],
            :field_format => "int", :possible_values => [], :regexp => "", :is_required => true, :is_for_all => false,
            :is_filter => false, :searchable => false, :editable => true)
          ProjectCustomField.create(:type => "ProjectCustomField", :name => DEFAULT_VALUES['project_group_field'],
            :field_format => "list", :possible_values => ['Aplicaciones','Distribuciones','Migraciones','GPI','GIS','Otros'],
            :regexp => "", :is_required => true, :is_for_all => false, :is_filter => false, :searchable => false, :editable => false)

          UserCustomField.create(:type => "UserCustomField", :name => DEFAULT_VALUES['user_role_field'],
            :field_format => "list", :possible_values => ['JP', 'AF', 'AP', 'PS', 'PJ', 'B'],
            :regexp => "", :is_required => true, :is_for_all => false, :is_filter => false, :searchable => false, :editable => false, :default_value => nil)
        end
      end
    end
  end
end
