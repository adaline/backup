# encoding: utf-8

require 'fileutils'
require 'yaml'

##
# The Backup Ruby Gem
module Backup

  ##
  # List the available database, storage, compressor, encryptor and notifier constants.
  # These are used to dynamically define these constants as classes inside Backup::Finder
  # to provide a nicer configuration file DSL syntax to the users. Adding existing constants
  # to the arrays below will enable the user to use a constant instead of a string.
  # Example, instead of:
  #  database "MySQL" do |mysql|
  # You can do:
  #  database MySQL do |mysql|
  DATABASES   = ['MySQL']
  STORAGES    = ['S3']
  COMPRESSORS = ['Gzip']
  ENCRYPTORS  = ['OpenSSL']
  NOTIFIERS   = []

  ##
  # Backup's internal paths
  LIBRARY_PATH       = File.join(File.dirname(__FILE__), 'backup')
  CONFIGURATION_PATH = File.join(LIBRARY_PATH, 'configuration')
  STORAGE_PATH       = File.join(LIBRARY_PATH, 'storage')
  DATABASE_PATH      = File.join(LIBRARY_PATH, 'database')
  COMPRESSOR_PATH    = File.join(LIBRARY_PATH, 'compressor')
  ENCRYPTOR_PATH     = File.join(LIBRARY_PATH, 'encryptor')
  NOTIFIER_PATH      = File.join(LIBRARY_PATH, 'notifier')

  ##
  # Backup's Environment paths
  TMP_PATH           = File.join(ENV['HOME'], 'Backup', '.tmp')
  DATA_PATH          = File.join(ENV['HOME'], 'Backup', 'data')
  CONFIG_FILE        = File.join(ENV['HOME'], 'Backup', 'config.rb')

  ##
  # Autoload Backup base files
  autoload :Model,   File.join(LIBRARY_PATH, 'model')
  autoload :Archive, File.join(LIBRARY_PATH, 'archive')
  autoload :CLI,     File.join(LIBRARY_PATH, 'cli')
  autoload :Finder,  File.join(LIBRARY_PATH, 'finder')
  autoload :Version, File.join(LIBRARY_PATH, 'version')

  ##
  # Autoload Backup configuration files
  module Configuration
    autoload :Base,     File.join(CONFIGURATION_PATH, 'base')
    autoload :Helpers,  File.join(CONFIGURATION_PATH, 'helpers')
  end

  ##
  # Autoload Backup storage files
  module Storage
    autoload :Base,   File.join(STORAGE_PATH, 'base')
    autoload :Object, File.join(STORAGE_PATH, 'object')
    autoload :S3,     File.join(STORAGE_PATH, 's3')

    module Configuration
      autoload :Base, File.join(STORAGE_PATH, 'configuration', 'base')
      autoload :S3,   File.join(STORAGE_PATH, 'configuration', 's3')
    end
  end

  ##
  # Autoload Backup database files
  module Database
    autoload :MySQL, File.join(DATABASE_PATH, 'mysql')
  end

  ##
  # Autoload compressor files
  module Compressor
    autoload :Gzip, File.join(COMPRESSOR_PATH, 'gzip')
  end

  ##
  # Autoload encryptor files
  module Encryptor
    autoload :OpenSSL, File.join(ENCRYPTOR_PATH, 'open_ssl')
  end

  ##
  # Autoload notification files
  module Notifier
    autoload :Base, File.join(NOTIFIER_PATH, 'base')
    autoload :Mail, File.join(NOTIFIER_PATH, 'mail')

    module Configuration
      autoload :Base, File.join(NOTIFIER_PATH, 'configuration', 'base')
      autoload :Mail, File.join(NOTIFIER_PATH, 'configuration', 'mail')
    end
  end

  ##
  # Dynamically defines all the available database, storage, compressor, encryptor and notifier
  # classes inside Backup::Finder to improve the DSL for the configuration file
  (DATABASES + STORAGES + COMPRESSORS + ENCRYPTORS + NOTIFIERS).each do |constant|
    Backup::Finder.const_set(constant, Class.new)
  end

end
