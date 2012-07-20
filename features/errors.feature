Feature: The Forth interpreter shall throw meaningfull errors

  Background:
    Given a forth interpreter

  Scenario: Stack is empty
     When I execute "."
     Then I should receive the error "stack is empty"
