#!/bin/bash
# ./gen-fixture.sh spec/fixtures/example_spec.rb
# ./gen-fixture.sh spec/fixtures/example_spec.rb sample

bundle exec rspec --format RSpecCodewarsFormatter $1 > "${1%.rb}.${2:-expected}.txt"
