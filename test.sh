#!/bin/bash

echo "*** Running breadcrumbs specs"

bundle install         || exit 1
bundle exec rspec spec || exit 1
