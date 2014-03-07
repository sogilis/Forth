Feature: The Forth interpreter shall understand comments

  Background:
    Given a forth interpreter

  Scenario: Comment in an addition
     When I execute "3 ( 6 ) 5 + ."
     Then I should get "8 ok"

