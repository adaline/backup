# encoding: utf-8

module Backup
  module Notifier
    class Base
      include Backup::Configuration::Helpers

      ##
      # When set to true, the user will be notified by email
      # when a backup process ends without raising any exceptions
      attr_accessor :on_success

      ##
      # When set to true, the user will be notified by email
      # when a backup process raises an exception before finishing
      attr_accessor :on_failure
    end
  end
end
