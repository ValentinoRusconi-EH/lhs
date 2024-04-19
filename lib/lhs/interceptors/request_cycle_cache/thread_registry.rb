# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/module/attribute_accessors_per_thread'

module LHS
  module Interceptors
    module RequestCycleCache
      extend ActiveSupport::Concern

      class ThreadRegistry
        # Using thread_mattr_accessor to manage thread-local storage for request_id.
        thread_mattr_accessor :request_id
      end
    end
  end
end
