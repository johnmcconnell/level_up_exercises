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
    When I remove <item_id>s
    Then I should have 0 <item_id>s

