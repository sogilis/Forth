Feature: The Forth interpreter shall accept function definitions

  Background:
    Given a forth interpreter

  Scenario: If True
     When I execute ": x DUP . . ; 1 x"
     Then I should get "1 1 ok"

