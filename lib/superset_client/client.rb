# frozen_string_literal: true

require "json"
require "faraday"
require "faraday-cookie_jar"

module SupersetClient
  class Client
    attr_accessor :base_url, :http_conn, :access_token

    def initialize(base_url, username, password)
      @base_url = base_url

      login(username, password)

      @http_conn = Faraday.new(url: base_url,
                               headers: { "Content-Type": "application/json",
                                          Authorization: "Bearer #{@access_token}" }) do |f|
        f.use :cookie_jar # Add the cookie jar middleware
      end
    end

    def login(username, password)
      resp = Faraday.post("#{base_url}/security/login",
                          { username: username, password: password, provider: "db" }.to_json,
                          { "Content-Type" => "application/json" })

      @access_token = JSON.parse(resp.body)["access_token"]
    end

    def csrf_token
      resp = @http_conn.get("security/csrf_token/")
      JSON.parse(resp.body)["result"]
    end

    def charts(page: 0, page_size: 20)
      query_param = format_query_param({ page: page, page_size: page_size })
      resp = @http_conn.get("chart/", q: query_param)
      JSON.parse(resp.body)
    end

    def chart(id)
      resp = @http_conn.get("chart/#{id}")
      JSON.parse(resp.body)
    end

    def create_chart(chart_params)
      resp = @http_conn.post("chart/", chart_params.to_json) do |req|
        req.headers["X-CSRFToken"] = csrf_token
      end
      JSON.parse(resp.body)
    end

    def dataset(id)
      resp = @http_conn.get("dataset/#{id}")
      JSON.parse(resp.body)
    end

    def create_dataset(dataset_params)
      resp = @http_conn.post("dataset/", dataset_params.to_json) do |req|
        req.headers["X-CSRFToken"] = csrf_token
      end
      JSON.parse(resp.body)
    end

    def databases(page: 0, page_size: 20)
      query_param = format_query_param({ page: page, page_size: page_size })
      resp = @http_conn.get("database/", q: query_param)
      JSON.parse(resp.body)
    end

    def database(id)
      resp = @http_conn.get("database/#{id}")
      JSON.parse(resp.body)
    end

    def database_connection(id)
      resp = @http_conn.get("database/#{id}/connection")
      JSON.parse(resp.body)
    end

    def create_database(database_params)
      resp = @http_conn.post("database/", database_params.to_json) do |req|
        req.headers["X-CSRFToken"] = csrf_token
      end
      JSON.parse(resp.body)
    end

    def dashboard(id)
      resp = @http_conn.get("dashboard/#{id}")
      JSON.parse(resp.body)
    end

    def create_dashboard(dashboard_params)
      resp = @http_conn.post("dashboard/", dashboard_params.to_json) do |req|
        req.headers["X-CSRFToken"] = csrf_token
      end
      JSON.parse(resp.body)
    end

    def format_query_param(query)
      "(#{query.map { |k, v| "#{k}:#{v}" }.join(',')})"
    end
  end
end
