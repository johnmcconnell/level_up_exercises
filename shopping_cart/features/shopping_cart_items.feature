Feature: Shopping Cart
  As a user, I should be able to
  add, remove, and change quantities
  the items.
  As a user, I should be able to
  view product pages of items in
  my cart
  As a user, my cart should not
  disappear

  Scenario:I can add new items
    Given My cart is empty
    When I add 2 "A101"s
    And I add 6 "C302"s
    And I add 1 "B331"s
    And I add 1 "B331"s
    Then I should have 2 "A101"s
    And I should have 6 "C302"s
    And I should have 2 "B331"s

  Scenario: I can remove items
    Given I have 2 "A101"s
    And I have 4 "B332"s
    And I have 6 "R202"s
    When I remove "A101"s
    And I remove "R202"s
    Then I should have 0 "A101"s
    And I should have 0 "R202"s

  Scenario: I can change item quantity
    Given I have 3 "A101"s
    And I have 1 "D404"s
    And I have 5 "G808"s
    When I update quantity of "A101"s to 2
    And I update quantity of "D404"s to 7
    Then I should have 2 "A101"s
    And I should have 7 "D404"s
    And I should have 5 "G808"s

  Scenario: My cart can display item pages
    Given I have 2 "C303"s
    When I click on "C303"
    Then I should be on the "C303" page

  Scenario: My cart keeps items when I leave the site
    Given I have 2 "A101"s
    And I have 3 "C303"s
    When I visit another website
    And I come back to the shopping cart page
    Then I should have 2 "A101"s
    And I should have 3 "C303"s

  Scenario: My cart works when I login
    Given My cart is empty
    When I login
    And I add 2 "A101"s
    And I add 1 "Q707"s
    Then I should have 2 "A101"s
    And I should have 1 "Q707"s

  Scenario: My carts can be merged
    Given I have 2 "A101"s
    And I have 2 "C303"s
    When I login
    And I add 1 "A101"s
    And I add 1 "D303"s
    And I merge carts
    Then I should have 3 "A101"s
    And I should have 2 "C303"s
    And I should have 1 "D303"s

  Scenario: My carts don't have to be merged
    Given I have 1 "A101"s
    When I login
    And I add 2 "A101"s
    And I do not merge carts
    And I logout
    Then I should have 1 "A101"s

  Scenario: My cart keeps items between logins
    Given I am logged in
    And I have 2 "A101"s
    When I logout
    And I login
    Then I should have 2 "A101"s
