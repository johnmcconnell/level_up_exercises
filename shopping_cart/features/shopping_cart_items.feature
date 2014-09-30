Feature: Shopping Cart Items
  As a user, I should be able to
  add, remove, and change quantities
  the items.

  Scenario: Add new items
    Given My cart is empty
    When I add 2 "A101"s
    And I add 6 "C302"s
    And I add 1 "B331"s
    Then I should have 2 "A101"s
    And I should have 6 "C302"s
    And I should have 1 "B331"s

  Scenario: Remove items
    Given I have 2 "A101"s
    And I have 4 "B332"s
    And I have 6 "R202"s
    When I remove "A101"s
    And I remove "R202"s
    Then I should have 0 "A101"s
    And I should have 0 "R202"s

  Scenario: Change item quantity
    Given I have 3 "A101"s
    And I have 1 "D404"s
    And I have 5 "G808"s
    When I update quantity of "A101"s to 2
    And I update quantity of "D404"s to 7
    Then I should have 2 "A101"s
    And I should have 7 "D404"s
    And I should have 5 "G808"s
