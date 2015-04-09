@smoke
Feature: Saves permanent config data in home folder.
  To avoid command line definition of all the permanent config data
  As a yarrr player
  I should be able to start the client to reuse configuration in the home folder

  Scenario: Client creates home folder if it does not exist.
    When I start a client
    Then relative directory should exist in the home directory .yarrr

