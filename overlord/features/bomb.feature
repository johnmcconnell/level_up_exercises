Feature: Bomb
  The bomb should be activated by a numeric code.
  A person should be allowed 2 attempts to
    deactivate the bomb.
  The bomb should only be deactivated by the same
  code to activate it.
  The bomb should not be activated if the safe
    wire is cut.
  The bomb should explode if a live wire
    is cut.

  Scenario: The user wishes to activate the
    bomb
    Given The bomb is not armed
    When The user enters a valid code "0123"
    Then The bomb should be armed

  Scenario: The user wishes to dearmed the
    bomb
    Given The bomb is armed with code "0123"
    When The user enters a valid code "0123"
    Then The bomb should not be armed

  Scenario: The user wishes to dearmed the
    bomb, after a bad guess
    Given The bomb is armed with code "0123"
    When The user enters a valid code "1111"
    And The user enters a valid code "0123"
    Then The bomb should not be armed

  Scenario: The user fails to deactivate the
    bomb
    Given The bomb is armed with code "0123"
    When The user enters a valid code "1111"
    And The user enters a valid code "1111"
    Then The bomb should be blown up

  Scenario: The user cuts the safe wire
    Given The bomb is armed with code "1234"
    When The user cuts the good wire
    And The user enters a valid code "1111"
    And waits for the time to expire
    Then The bomb should not be blown up

  Scenario: The user cuts a live wire while
    armed
    Given The bomb is armed with code "1234"
    When The user cuts a live wire
    Then The bomb should be blown up

  Scenario: The user cuts a live wire while
    not armed
    Given The bomb is not armed
    When The user cuts a live wire
    Then The bomb should be blown up

  Scenario: The user wishes to set the timer
    Given The bomb is not armed
    When The user sets the time to "45"
    And The user enters a valid code "1234"
    Then The bomb should be armed
    And The timer be close to "45"

  Scenario: The user waits too long
    Given The bomb is not armed
    When The user enters a valid code "1111"
    And waits for the time to expire
    Then The bomb should be blown up
