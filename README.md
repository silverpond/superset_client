# Superset Client

A Ruby client for interacting with Apache Superset's REST API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'superset_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install superset_client

## Usage

```ruby
# Create a new client
client = SupersetClient.new('https://your-superset-instance', 'username', 'password')

# Or if you prefer the explicit form
client = SupersetClient::Client.new('https://your-superset-instance', 'username', 'password')

# Get all charts
charts = client.charts

# Get a specific chart
chart = client.chart(123)

# Create a new chart
new_chart = client.create_chart({
  slice_name: "My New Chart",
  viz_type: "line",
  # ... other params
})
```

## Development

After checking out the repo, run `nix-shell` to install dependencies. Then, run `bundle exec spec` to run the tests.

## License

The gem is available as open source under the terms of the MIT License.
