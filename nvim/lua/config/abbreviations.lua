local abbrevs = {
  teh = 'the',
  adn = 'and',
  recieve = 'receive',
  functoin = 'function',
}

for wrong, right in pairs(abbrevs) do
  vim.cmd(string.format('iabbrev %s %s', wrong, right))
end
