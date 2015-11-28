# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end


#
# Then the director of "Alien" should be "Ridley Scott"
#

Then /the (.*) of "(.*)" should be "(.*)"/ do |field_name, title, field_value|
#  assert_match(Movie.where(title: title).select(field_name), field_value)
  step "I should see \"#{title}\" before \"#{field_value}\""
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).to have_xpath('//*', :text => /#{e1}.*#{e2}/)
end



# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    step "I #{uncheck}check \"ratings[#{rating}]\""      
  end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  within('table#movies') do
    expect(page).to have_xpath(".//tr", :count => Movie.count+1)
  end
end
