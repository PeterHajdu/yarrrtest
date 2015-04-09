@smoke
Feature: Network access to model system
  To debug the system
  As a yarrr developer
  I should be able to access the model system on a running server process

  Scenario: starting the server with remote model port parameter
    Given a running server
    Then I should be able to get model information

