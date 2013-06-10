Feature: The Forth interpreter shall understand basic operations

  Background:
    Given a forth interpreter

  Scenario: Addition
     When I execute "3 4 + ."
     Then I should get "7 ok"

  Scenario: Substraction
     When I execute "3 4 - ."
     Then I should get "-1 ok"

  Scenario: Multiplication
     When I execute "3 4 * ."
     Then I should get "12 ok"

