Given /^a clean forth interpreter$/ do
  open_forth!
end

Given /^a forth interpreter$/ do
  open_forth
end

When /^I execute "([^"]*)"$/ do |arg|
  @forth_i.read(2).should == "> "
  @forth_o.puts "#{arg}\n"
end

Then /^I should get "([^"]*)"$/ do |arg|
  @forth_i.gets.should == "#{arg}\n"
end

Then /^I should get$/ do |string|
  got = ""
  string.split("\n").length.times do
    got += @forth_i.gets
  end
  got.should == "#{string}\n"
end

Then /^I should receive the error "([^"]*)"$/ do |error_message|
  @forth_i.gets.should include error_message
end
