# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'dsn'
require 'minitest/autorun'

module MiniTest
  # Monkeypatch to add `context` helper
  class Spec
    class << self
      alias context describe
    end
  end
end
