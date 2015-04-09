@smoke
Feature: Saves authentication token to the home folder
  To avoid the need to remember authentication tokens
  As a yarrr player
  I should be able to start the client without specifying the token in the command line

  Scenario: The saved authentication token is the same as in the database
    Given a connected client with name hablabla
    Then permanent configuration file "hablabla.token" should contain authentication token of user "hablabla"

