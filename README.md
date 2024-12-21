# Illustration of surprising Sorbet behavior

This repo is meant to provide a minimal repro case for a surprising Sorbet behavior that I discovered.

## Setting up

Clone this repo and then run `bundle`.

## Expected behaviors

`bundle exec srb tc` should produce diagnostics indicating errors on both the call to `BasicTest.test` and `StructTest.new`.

However, running `ruby example.rb` should finish successfully with no output.

## Actual behaviors

`bundle exec srb tc` works as expected.

Running `ruby example.rb` crashes on the call to `StructTest.new`

## Analysis

Although one might expect the line `T::Configuration.default_checked_level = :never` to suppress _all_ typechecks that are not otherwise annotated, it does not affect type checking for `T::Struct`s because they neither check the value nor provide a configuration option to control typechecking behavior.

By itself, this might not seem like a _terrible_ issue, but it is one of the factors underlying the Tapioca issue described here: https://github.com/Shopify/tapioca/issues/2130
