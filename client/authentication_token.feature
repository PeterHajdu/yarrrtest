@smoke
Feature: Saves authentication token to the home folder
  To avoid the need to remember authentication tokens
  As a yarrr player
  I should be able to start the client without specifying the token in the command line

  Scenario: Client creates home folder if it does not exist.
    Given a connected client with name hablabla
    Then permanent client configuration file should exist with name hablabla.token

