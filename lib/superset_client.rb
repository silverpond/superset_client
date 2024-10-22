# frozen_string_literal: true

require "superset_client/version"
require "superset_client/client"

module SupersetClient
  class Error < StandardError; end

  # Convenience method to create a new client
  def self.new(base_url, username, password)
    Client.new(base_url, username, password)
  end
end
