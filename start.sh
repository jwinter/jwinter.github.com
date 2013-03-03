#!/bin/sh
cd blog-builder
jekyll
jekyll --server &
open http://localhost:4000/
say -v zarvox "Write something"
fg

