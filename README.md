# SimilarCount

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/similar_count`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'similar_count'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install similar_count

## Usage
```bash
$ bundle init
$ bundle add similar_count
$ bundle install
$ bundle exec irb 
```
```bash
$ mkdir "file_test"
$ echo -n "qwerty" > file_test/file_1.txt
$ echo -n "qwerty" > file_test/file_2.txt
$ echo -n "qwerty" > file_test/file_3.txt
$ echo -n "asdf" > file_test/file_4.txt
$ echo -n "asdf" > file_test/file_5.txt
```

```bash
irb(main):001:0> require('similar_count') # true
irb(main):002:0> path = "file_test" 
irb(main):003:0> result = SimilarCount::Scanner.scan_directory(path) # {:text=>"qwerty 3", :content=>"qwerty", :max_count=>3, :max_hash=>"65e84be33532fb784c48129675f9eff3a682b27168c0ea744b2cf58"
irb(main):004:0> puts result[:text] # qwerty 3
```




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/namakukingkong/similar_count.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
