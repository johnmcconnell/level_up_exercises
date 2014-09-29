Feature: Shopping Cart Items
  As a user, I should be able to
  add, remove, and change quantities
  the items.

  Scenario: Set item quantity
    Given My cart is empty
    When I add <quantity> <item_id>s
    Then I should have <quantity> <item_id>s

    Examples:
      | quantity | item_id |
      | 3 | A202 |
      | 7 | B333 |
      | 2 | Q951 |
      | 4 | N341 |

  Scenario: Remove items
    Given I have <quantity> <item_id>s
    When I remove <item_id>s
    Then I should have 0 <item_id>s

    Examples:
      | quantity | item_id |
      | 3 | G211 |
      | 5 | F042 |
      | 1 | G052 |
