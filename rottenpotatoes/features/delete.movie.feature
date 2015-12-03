Feature: add a new movie
 
  As a movie watcher
  So that I can quickly clean the movie list
  I want to delete an existing movie in the DB

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page

Scenario: delete an existing movie

#  When I go to the details page for "Amelie"
  When I follow "More about Amelie"
  And I press "Delete"
  Then I should be on the home page
  And I should not see "More about Amelie"
  And I should see "More about Aladdin"



