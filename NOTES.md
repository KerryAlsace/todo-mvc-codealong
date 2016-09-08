# Step 1: Integrate Basic Theme to Asset Pipeline

[X] / - And see a stubbed out, non-dynamic, page with the theme.

# Step 2: Allow people to CRUD lists.
I want people to be able to create lists. Then they should be able to add items to those lists. They should be able to navigate many lists and see each list's items. (Feature Story)

Take the nouns:

lists
  has many items

items
  belongs to a list

[ ] ListsController
  #index
  - see all their lists
  - doubling as my #new action in that it is presenting the person with a form to create a new list
  / - Index all the lists...
- create a list

- show a list

- i need a model
- i need a controller
- i should a generate resource

Does it impact the DB?
Does it impact my URLS? '/lists/1' #

# Step 3: Add Items to a List

# Step Whatever: Fix Down Arrow on Make a List Form


1. In terminal:
  `rails new todo-mvc-codealong`
  `cd todo-mvc-codealong/`
  `git init`
  `git add .`
  `git commit -m "init"`
2. Create new repository in github called 'todo-mvc-codealong', then in terminal:
  `git remote add origin git@github.com:KerryAlsace/todo-mvc-codealong.git`
  `git push -u origin master`
3. Create NOTES.md and start planning app (above)
4. Create file app/assets/stylesheets/todomvc-base.css
5. Copy and paste text from https://github.com/tastejs/todomvc/blob/master/examples/vanillajs/node_modules/todomvc-app-css/index.css into that new file
6. In config/routes.rb:
    root 'site#index'
7. In terminal:
  `rails g controller site index`
  `rails s`
8. In browser check that template renders:
  http://localhost:3000/
9. In app/assets/stylesheets/application.css:
  replace `require_tree .` with `require todomvc-base`, but keep commented out for now
10. 
