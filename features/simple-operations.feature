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
     When I execute "5 7 * ."
     Then I should get "35 ok"

  Scenario: Division
    When I execute "45 15 / ."
    Then I should get "3 ok"

  Scenario: Multiplication and addition
    When I execute "25 10 * 50 + ."
    Then I should get "300 ok"

  Scenario: Duplication
    When I execute "1 DUP . ."
    Then I should get "1 1 ok"
