Fabricator(:expense_split) do
  recipient
  expense
  amount      { Faker::Number.decimal(l_digits: 8, r_digits: 2) }
end