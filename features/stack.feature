Feature: The Forth interpreter shall understand stack operations

  Background:
    Given a forth interpreter

  Scenario: Drop Top Element
     When I execute "1 2 DROP ."
     Then I should get "1 ok"
