# HTML parser
[![Build Status](https://travis-ci.org/cema-sp/html_parser.svg?branch=master)](https://travis-ci.org/cema-sp/html_parser)

Simple API to fetch URL and parse H1, H3, H3 and A tags.

## Stack

* Ruby 2.3.3
* Rails 5.0
* Puma

## ENV vars

* `HTML_PARSER_DB_NAME` - database name

## API

### `GET /requests`, `GET /requests/:id`

Returns list of previous requests / request by id with results:

~~~json
{
  "id": "<request id>",
  "state": "<request state>",
  "data": {
    "h1": [<texts>],
    "urls": [<urls>]
  },
  ...
}
~~~

**state** - current request state (`pending`, `success`, `fail`)

### `POST /requests`

Creates a new request and schedules its processing. Returns:

~~~json
{
  "id": "<request id>",
  "state": "<request state>",
  ...
}
~~~


## Installation

1. Clone repo
2. Prepare DB & set ENV vars (see [ENV vars](#env-vars))
3. `bundle install`
4. `rails db:migrate`
5. Run test suite: `rails t`
6. Start server: `rails s`

## Example usage

1. Run server (see [Installation](#installation) or use [heroku])
2. Create request

  ~~~
  curl -i http://localhost:3000/requests -XPOST -H "Content-Type: application/json" -d '{"url": "http://angel.co"}'
  curl -i http://html-parser.herokuapp.com/requests -XPOST -H "Content-Type: application/json" -d '{"url": "http://angel.co"}'
  ~~~

3. Remember returned **id**
4. Get result (_1_ = **id**)

  ~~~
  curl -i http://localhost:3000/requests/1
  curl -i http://html-parser.herokuapp.com/requests/1
  ~~~

5. List all requests

  ~~~
  curl -i http://localhost:3000/requests
  curl -i http://html-parser.herokuapp.com/requests
  ~~~

[heroku]: http://html-parser.herokuapp.com "Simple HTML parser"
