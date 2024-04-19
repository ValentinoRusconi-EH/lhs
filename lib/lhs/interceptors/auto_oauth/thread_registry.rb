# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/module/attribute_accessors_per_thread'

module LHS
  module Interceptors
    module AutoOauth
      extend ActiveSupport::Concern
      class ThreadRegistry
        # Using thread_mattr_accessor which is part of ActiveSupport core_ext to manage thread-local access.
        thread_mattr_accessor :access_token
      end
    end
  end
end
