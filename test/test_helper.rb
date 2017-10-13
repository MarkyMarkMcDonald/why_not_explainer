$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "why_not_explainer"

require "minitest/autorun"

require 'active_record'
ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/test.sqlite3'
)