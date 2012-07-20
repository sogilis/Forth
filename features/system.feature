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
