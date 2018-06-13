# FindNearDate

find record by date from DB tables that is not indexed by date column (for ActiveRecord)

Caution: not for production app. for only human operation help.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'find_near_date'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_near_date

## Usage

app/models/foo.rb

```ruby
class Foo < ActiveRecord::Base
end
```

lib/pry_helper.rb

```ruby
require "find_near_date"

class Foo
  extend FindNearDate
end
```

in pry

```
> require "lib/pry_helper"
> foo_10days_ago = Foo.find_near_date(10.days.ago, :updated_at, period: 1.day)
```

etc.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Narazaka/find_near_date.

## License

This is released under the [Zlib License](https://narazaka.net/license/Zlib?2018)
