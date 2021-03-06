# encoding: utf-8

module Backup
  module Syncer
    class CloudFiles < Cloud

      ##
      # Rackspace CloudFiles Credentials
      attr_accessor :api_key, :username

      ##
      # Rackspace CloudFiles Container
      attr_accessor :container

      ##
      # Rackspace AuthURL allows you to connect to a different Rackspace datacenter
      # - https://auth.api.rackspacecloud.com     (Default: US)
      # - https://lon.auth.api.rackspacecloud.com (UK)
      attr_accessor :auth_url

      ##
      # Improve performance and avoid data transfer costs by setting @servicenet to `true`
      # This only works if Backup runs on a Rackspace server
      attr_accessor :servicenet

      private

      ##
      # Established and creates a new Fog storage object for CloudFiles.
      def connection
        @connection ||= Fog::Storage.new(
          :provider             => provider,
          :rackspace_username   => username,
          :rackspace_api_key    => api_key,
          :rackspace_auth_url   => auth_url,
          :rackspace_servicenet => servicenet
        )
      end

      ##
      # Creates a new @repository_object (container). Fetches it from Cloud Files
      # if it already exists, otherwise it will create it first and fetch use that instead.
      def repository_object
        @repository_object ||= connection.directories.get(container) ||
          connection.directories.create(:key => container)
      end

      ##
      # This is the provider that Fog uses for the Cloud Files
      def provider
        "Rackspace"
      end

    end
  end
end
