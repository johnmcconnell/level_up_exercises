Given(/^The bomb is not armed$/) do
  visit('/reset')
  expect(codebox_bomb_caption).to have_content(bomb_not_armed)
end

When(/^The user enters a valid code "(.*?)"$/) do |code|
  enter_code(code)
end

Then(/^The bomb should be armed$/) do
  expect(codebox_bomb_caption.text).to have_content(bomb_armed)
end

Given(/^The bomb is armed with code "(.*?)"$/) do |code|
  enter_code(code)
end

Then(/^The bomb should not be armed$/) do
  expect(codebox_bomb_caption.text).to have_content(bomb_not_armed)
end

Then(/^The bomb should be blown up$/) do
  expect(page).to have_content(explosion_message)
end

When(/^The user cuts the good wire$/) do
  find(".safe-wire").click
end

When(/^The user cuts a live wire$/) do
  all(".live-wire").first.click
end

Then(/^The bomb should not be blown up$/) do
  expect(page).to_not have_content(explosion_message)
end

When(/^The user sets the time to "(.*?)"$/) do |seconds|
  click_time_to_match_seconds(seconds)
end

Then(/^The timer be close to "(.*?)"$/) do |seconds|
  expect(find("#timer-time", :visible => false)[:value].to_i).to be_within(2).of(seconds.to_i)
end

When(/^The user waits for the time to expire$/) do
    click_time_to_match_seconds("1")
end
