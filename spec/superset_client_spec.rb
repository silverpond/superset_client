# frozen_string_literal: true

RSpec.describe SupersetClient::Client do
  let(:base_url) { "http://superset.example.com" }
  let(:username) { "test_user" }
  let(:password) { "test_password" }
  let(:access_token) { "test_token" }

  before do
    # Mock the login request
    stub_request(:post, "#{base_url}/security/login")
      .with(
        body: {
          username: username,
          password: password,
          provider: "db"
        }.to_json,
        headers: {
          "Content-Type" => "application/json"
        }
      )
      .to_return(
        status: 200,
        body: { access_token: access_token }.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end

  describe "#initialize" do
    it "sets up the client with correct authentication" do
      client = described_class.new(base_url, username, password)
      expect(client.access_token).to eq(access_token)
      expect(client.base_url).to eq(base_url)
    end
  end

  describe "#charts" do
    let(:client) { described_class.new(base_url, username, password) }
    let(:charts_response) { { "result" => [{ "id" => 1, "name" => "Test Chart" }] } }

    before do
      stub_request(:get, "#{base_url}/chart/")
        .with(query: { q: "(page:0,page_size:20)" })
        .to_return(
          status: 200,
          body: charts_response.to_json,
          headers: { "Content-Type" => "application/json" }
        )
    end

    it "fetches charts with default pagination" do
      response = client.charts
      expect(response).to eq(charts_response)
    end
  end
end
