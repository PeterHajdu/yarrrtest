@smoke
Feature: User login
  To be able to play with the same character
  As a player
  I should be able to log in with my registered user

  Scenario: The server allows existing users login
    Given a running server
    And a registered user "known_user" with auth_token "dogfood"
    When I start a client with command line parameter --username known_user --auth_token dogfood
    And I gather model information
    Then a player with name "known_user" should be online

  Scenario: The server does not allow non existing user login.
    Given a running server
    When I start a client with command line parameter --username unknown_user --auth_token dogfood
    And I gather model information
    Then a player with name "unknown_user" should not be online

  Scenario: The server does not allow existing user login without the correct authentication token.
    Given a running server
    And a registered user "known_user" with auth_token "dogfood"
    When I start a client with command line parameter --username known_user --auth_token catbeverage
    And I gather model information
    Then a player with name "known_user" should not be online

