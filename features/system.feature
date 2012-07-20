Feature: The Forth interpreter shall understand system commands

  Background:
    Given a forth interpreter

  Scenario: STACK command displays the content of the stack
    When I execute "3 1 2 STACK"
    Then I should get "3 1 2 ok"

  Scenario: STACK command does not change the stack
    When I execute "3 1 2 STACK"
    Then I should get "3 1 2 ok"
    When I execute "STACK"
    Then I should get "3 1 2 ok"

  Scenario: VERSION
    When I execute "VERSION ."
    Then I should get "3.14 ok"

  Scenario: EXIT
    When I execute "1 . EXIT 2 ."
    Then I should get "1 exited"
