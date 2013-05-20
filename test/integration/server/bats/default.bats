#!/usr/bin/env bats

@test "should be running mysql" {
  [ "$(ps aux | grep mysql)" ]
}
