#!/bin/sh
cd blog-builder
# Depends on jekyll version 0.12.1
jekyll
jekyll --server &
open http://localhost:4000/
say -v zarvox "Write something"
echo "New posts go in blog-builder/source/_posts and look like YYYY-MM-DD-TITLE.{html|md}"
fg
