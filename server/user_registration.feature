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
    And the client should see "Unable to log in.  Please restart the client with the --username command line parameter.  If you are unable to solve the issue send an email to info@yarrrthegame.com"

  @wip
  Scenario: The server handles well invalid username requests
    Given a running server
    When I start a client with command line parameter --username "Kilgore Trout"
    Then the server should be running
    And the client should see "Invalid username.  Username must not contain the following characters: space"

