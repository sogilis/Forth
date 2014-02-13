Feature: The Forth interpreter shall understand basic operations

  Background:
    Given a forth interpreter

  Scenario: Float Input
     When I execute "5.5 4 . ."
     Then I should get "4 5.5 ok"

  Scenario: Addition
     When I execute "3 4 + ."
     Then I should get "7 ok"

  Scenario: Substraction
     When I execute "3 4 - ."
     Then I should get "-1 ok"

  Scenario: Multiplication
     When I execute "3 4 * ."
     Then I should get "12 ok"

  Scenario: Duplication
     When I execute "1 DUP . ."
     Then I should get "1 1 ok"

  Scenario: Division
     When I execute "5 2 / ."
     Then I should get "2.5 ok"

  Scenario: Quotient
     When I execute "5 2 // ."
     Then I should get "2 ok"

  Scenario: Modulo
     When I execute "5 2 % ."
     Then I should get "1 ok"

  Scenario: Negation
     When I execute "1 NEG ."
     Then I should get "-1 ok"
