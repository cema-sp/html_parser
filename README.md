# HTML parser
[![Build Status](https://travis-ci.org/cema-sp/html_parser.svg?branch=master)](https://travis-ci.org/cema-sp/html_parser)

Simple API to fetch URL and parse H1, H3, H3 and A tags.

## Stack

* Ruby 2.3.3
* Rails 5.0
* Puma

## ENV vars

* `HTML_PARSER_DB_NAME` - database name

## Installation

1. Clone repo
2. Prepare DB & set ENV vars (see [ENV vars](#env-vars))
3. `bundle install`
4. `rails db:migrate`
5. Run test suite: `rails t`
6. Start server: `rails s`

## Example usage

1. Run server (see [Installation](#installation) or use [heroku])
2. `curl -i http://localhost:3000/requests -XPOST -H "Content-Type: application/json" -d '{"url": "http://angel.co"}'`
3. Remember returned **id**
4. Get result: `curl -i http://localhost:3000/requests/1`, where _1_ = **id**
5. List all requests: `curl -i http://localhost:3000/requests`

[heroku]: https://heroku.com "Simple HTML parser"
