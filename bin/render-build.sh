#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle install --with development test
sudo ./bin/rails assets:precompile
sudo ./bin/rails assets:clean
