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

-Make the items in a list real
  - a list has many items
  - item belongs to a list
    -table:
      -description, list_id
CREATE ACTION for an ITEM in a LIST
  - The form is already on the list show page
  - What URL does this form imply?

  An item doesn't exist in our app outside of the context of the list it belongs to
  - Nested resource - items are nested in terms of URLs under their parent list

  POST /lists/:id/items

Does it impact the DB? - I probably need an items table and associate items with list
Does it impact my URLS? '/lists/1' # - I'll need a create action for an item in a list and what is the url for that?

# Step 4: Add Validations
  -Lists have a name
  -Item has a description

# Step 5: Add state to items in a list (complete, incomplete)
  -Mark items as complete/incomplete
    -Need to get that checkbox HTML from todomvc
    add this:
    <input class="toggle" type="checkbox">

    -Need JS function to submit the form when you click the checkbox

    $(function(){
      $("input.toggle").on("change", function(){
        $(this).parents("form").trigger("submit")
        })
      });

  -What URLs do I need?
    -new forms for updating status of an item = new URL
    -PUT/PATCH to /lists/:list_id/items/:id
  -How might my database change?
    -item being complete or incomplete needs to be stored

# Refactor 1. Start using partials in lists/show


# Step 6: Delete items from a list

  -I know i need a new delete button
  -I'll need a controller action
  -The delete will hit a new URL

# Step 7: User Signup and Login

  -How is it going to affect my db?
  a new model: user with email

  -What urls do I need?
    get /users/new
    post /users

    get /login
    post /sessions

# Step 8: Users have lists and can only see their lists


# Step Whatever: Fix Down Arrow on Make a List Form

PART 1 Assets and Lists

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
  -remove `require_self`
  -replace `require_tree .` with `require todomvc-base`, but keep commented out for now
10. In browser:
  go to: http://todomvc.com/examples/vanillajs/
  Inspect
  Delete the 'learn' thing
  inspect the text bar
  right click
  select "copy outerHTML" of <section class="todoapp">
11. In app/views/site/index.html.erb:
  Replace with copied text
  Delete everything between "<span class="todo-count">" and "</button>" in the footer
  Delete the input and label for "toggle-all"
  Delete destroy button
  Delete toggle checkbox
  Format lines under main section class
  Delete data-id (just id part)
  Delete the 2 style="display: block;" texts
  Duplicate the <li></li> with the list info and make a couple lists and make their titles clickable links
12. In terminal:
  `rails g resource list name:string`
  `rake db:migrate`
13. Test it out in terminal:
  `rails console`
  `List.create`
14. In routes.rb
  Change root to 'lists#index'
  Delete get 'site/index'
15. Copy the site index page's content
16. In terminal:
  `rails destroy controller site`
17. Create app/views/lists/index.html.erb and paste the content from the other index page
18. In lists_controller:
  def index
    @lists = List.all
  end
19. Change index.html.erb to render a loop of lists instead of the hardcoded lists we tested with
20. In lists_controller, check if worked:
  def index
    @lists = List.all
    raise @lists.inspect
  end
21. If successful, browser will show your 1 list item that you created in console as an error
22. `rake routes` in console to check out your routes
23. Make index.html.erb list links real with link_to:
  link_to list.name, list_path(list)
    * list_path = /lists/:id
    * list_url = html://localhost:3000/lists/:id
    All get routes have a prefix_path
    * list_path(list) = /lists/(list.id)
24. Create app/views/lists/show.html.erb
25. In lists_controller:
  def show
    @list = List.find(params[:id])
  end
26. Copy code from index.html.erb to show.html.erb and take out the ruby parts and replace with:
<label for="toggle-all">Add an item</label>
<ul class="todo-list">
  <li>
    <div class="view">
      <label>Milk</label>
    </div>
  </li>
27. Replace what's in h1 with <%= @list.name %>
28. Build form in index.html.erb:
  a. Replace header with:
  <h1>Your Lists</h1>
  <%= form_for(@list) do |f| %>
    <%= f.text_field :name, :class => "new-todo" %>
    <%= f.submit :style => "display: none" %>
  <% end %>
  </form>
29. Add to lists_controller:
    def create
      raise params.inspect
    end
30. After checking it out, replace with:
    def create
      @list = List.new
      @list.name = params[:list][:name]
      @list.save

      redirect_to list_url(@list)
    end


PART 2 Lists Have items

1. `rails g model item desription:string list_id:integer`
2. `rake db:migrate`
3. Add associations in models
4. Adjust views to add ability to add new item to list
5. `rails g controller items create`

PART 3 Mark Items complete

1. `rails g migration AddStatusToItems status:integer`
2. `rake db:migrate`
3. Add <input class="toggle" type="checkbox"> to lists#show page
4. `rake db:rollback`
5. add `, :integer, default: 0` to migration
6. `rake db:migrate`

PART 4 Refactoring with Partials and Helpers

1. The `content_tag_for` method has been removed from Rails. To continue using it, add the `record_tag_helper` gem to your Gemfile:
  gem 'record_tag_helper', '~> 1.0'
  -error received when adding the content_tag_for

PART 5 Authentication and Authorization

1. `rails g model user email:string`
2. `rake db:migrate`
3. `rails g controller users`
4. create users#new view and add create and validate
5. `rails g controller sessions`
6. add routes
7. `rails g migration AddPasswordDigestToUsers`
8. add `add_column :users, :password_digest, :string` to new migration
9. `rake db:migrate`
10. add gem 'bcrypt', '~> 3.1.7' to Gemfile
11. `bundle`

PART 6 Authentication
1. Add to gemfile:
  `gem 'omniauth'`
  `gem 'omniauth-github'`
  `bundle`
2. Create file config/initializers/omniauth.rb and add:
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    end
3. In routes.rb:
  `get '/auth/:provider/callback', to: 'sessions#create'`
4. On github.com:
  create an app and get its key and secret
5. in termnal:
  `export GITHUB_KEY=<your-key>`
  `export GITHUB_SECRET=<your-secret>`
6. test that it worked => in terminal
  `rails c`
  `ENV["GITHUB_KEY"]` (should return your key)
  `ENV["GITHUB_SECRET"]` (should return your secret)
7. `rails s`
  http://localhost:3000/auth/github (should redirect to authenticate)
8. add `raise "stop".inspect` to sessions#create
9. In the browser console you can do:
  request.class
  request.env["omniauth.auth"]
10. 
