#!/bin/sh
cd blog-builder
jekyll
jekyll --server &
open http://localhost:4000/
say -v zarvox "Write something"
echo "New posts go in source/_posts and look like YYYY-MM-DD-TITLE.{html|md}"
fg
