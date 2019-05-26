function fish_user_key_bindings
  for mode in insert default visual
    bind -M $mode \cf forward-char
  end
  bind -M default / reverse_history_search
end
