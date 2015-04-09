@smoke
Feature: User registration
  To be able to play with the same character
  As a player
  I should be able to register an account

  Scenario: The server creates a user in the database during login if it did not exist before.
    Given a running server
    And a running client without authentication token
    Then the default user should be created in the database

  Scenario: The server saves the authentication token for the new user.
    Given a running server
    And a running client without authentication token
    Then the default user should have auth_token

  Scenario: The server does not change the data of already existing users
    Given a running server
    And a registered default user with auth_token appletree
    And a running client without authentication token
    Then the default users auth_token should be appletree
