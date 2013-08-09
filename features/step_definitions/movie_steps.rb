# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_array = rating_list.split(", ")
  rating_array.each do |rating|
    if uncheck.nil?
      uncheck("ratings[#{rating}]")
    else
      check("ratings[#{rating}]")
    end
  end
end

# And I uncheck all but following ratings: PG, R

When /I uncheck all but following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_array = rating_list.split(", ")
  all_ratings = Movie.all_ratings
  ratings = all_ratings - rating_array
  ratings.each do |rating|
    uncheck("ratings[#{rating}]")
  end
end

# Then I should see Movies with following ratings: PG, R
#And I should not see Movies with following ratings: G, PG-13

Then /I should see movies with following ratings: (.*)/ do |rating_list|
  
  rating_array = rating_list.split(", ")
  movies = Movie.find_all_by_rating rating_array

  movies.each do |movie|

      page.should have_content(movie.title)

  end

end


Then /I should not see movies with following ratings: (.*)/ do |rating_list|
  
  rating_array = rating_list.split(", ")
  movies = Movie.find_all_by_rating rating_array
  debugger
  movies.each do |movie|

      page.should_not have_content(movie.title)

  end

end