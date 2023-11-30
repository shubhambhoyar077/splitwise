Fabricator(:expense) do
  payer
  total_amount      { Faker::Number.decimal(l_digits: 8, r_digits: 2) }
  description     { Faker::Lorem.sentence(word_count: 3)[0, 255] }
  date          { Date.today }
end