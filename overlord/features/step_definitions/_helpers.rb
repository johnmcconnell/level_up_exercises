def enter_code(code)
  code.chars.each { |character| click_code_button(character) }
  find("#codebox-enter").click
end

def click_code_button(character)
  click_button(character)
end

def codebox_bomb_caption
  find("#codebox caption strong")
end

def bomb_armed
  "Active Bomb!"
end

def bomb_not_armed
  "Not Active"
end

def explosion_message
  "You have perished my friend"
end

def click_time_to_match_seconds(seconds)
   seconds_to_change = 30 - seconds.to_i
   button = (seconds_to_change < 0) ? find("#timer-increment") : find("#timer-decrement")
   seconds_to_change.abs.times { button.click }
end
