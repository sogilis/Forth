Given /^a clean forth interpreter$/ do
  open_forth!
end

Given /^a forth interpreter$/ do
  open_forth
end

When /^I execute "([^"]*)"$/ do |arg|
  expect(@forth_i.read(2)).to eq("> ")
  @forth_o.puts "#{arg}\n"
end

Then /^I should get "([^"]*)"$/ do |arg|
  expect(@forth_i.gets).to eq("#{arg}\n")
end

Then /^I should get$/ do |string|
  got = ""
  string.split("\n").length.times do
    got += @forth_i.gets
  end
  expect(got).to eq("#{string}\n")
end

Then /^I should receive the error "([^"]*)"$/ do |error_message|
  expect(@forth_i.gets).to include(error_message)
end
