# Urbanite

Urbanite is a Rails application that provides an alternative interface for Urban Dictionary. It uses the Urban Dictionary API to fetch definitions and present them in a clean, dictionary-style format. [Try it out on urbanite.pukhanov.ru](https://urbanite.pukhanov.ru).

## Setup

Ensure you have Ruby 3.3.4 and Rails 7.1.3 installed. Clone the repository, then run `bundle install` to install dependencies. Start the server using `bin/dev`.

## Development

The application follows standard Rails conventions. The main components are the `TermsController` for handling term lookups and the `UrbanDictionaryService` for API interactions. Views are located in `app/views` and use Tailwind CSS for styling.

## Testing

The project uses RSpec for unit and integration testing, run tests with `bin/rspec`.

## Code Style

Rubocop is used for code linting and formatting. Run `bin/rubocop -a` to automatically fix style issues. The project follows the [Ruby Omakase style guide](https://github.com/rails/rubocop-rails-omakase).
