#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle install --with development test
./bin/rails assets:precompile
./bin/rails assets:clean
