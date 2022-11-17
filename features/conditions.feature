Feature: The Forth interpreter shall understand IF constructions

  Background:
    Given a forth interpreter

  Scenario: If True
     When I execute "3 5 < IF 1 . ELSE 2 . THEN 3 ."
     Then I should get "1 3 ok"

  Scenario: If False
     When I execute "6 5 < IF 1 . ELSE 2 . THEN 3 ."
     Then I should get "2 3 ok"

