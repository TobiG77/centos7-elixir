#!/usr/bin/env bash

test "$PATH" == "${PATH/usr\/local\/elixir\/bin/}" && PATH=$PATH:/usr/local/elixir/bin
