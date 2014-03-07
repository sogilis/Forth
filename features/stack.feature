Feature: The Forth interpreter shall understand stack operations

  Background:
    Given a forth interpreter

  Scenario: Drop Top Element
     When I execute "1 2 DROP ."
     Then I should get "1 ok"

  Scenario: Swap Top Two Elements
     When I execute "1 2 SWAP . ."
     Then I should get "1 2 ok"

  Scenario: CLEAR empties the stack
    When I execute "1 2 3 CLEAR"
    Then I should get "ok"
    When I execute "."
    Then I should receive the error "stack is empty"
