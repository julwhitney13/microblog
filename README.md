# Kim Whitney's Microblog

### Github Repo:
https://github.com/kimception/microblog

### Deployed Application
http://www.microblog.sorryiateallyourpancakes.com/

### Design Explanation

**Relationships**: When a user is logged in and viewing a single profile (/user :show) or a list of users (/user :index), there will be a follow or unfollow button. If they are currently following that user, they will only see an unfollow button. If they are not, they will only see a follow button. If the card is their profile, there obviously will not be any button. No follow or unfollow buttons are shown at all when a user is not logged in. I think this is pretty well implemented since a user has flexibility of where and when they can follow or unfollow a user. They are alerted if the action succeeded or failed and they remain on their last path.

**Login**: A user can log in at the top of the page with their email address when they are not logged in already. The nav bar will then display their username next to a logout button. They can log in or log out at any time / page. If they are not logged in, there is also a button to create an account. If a user tries to log in with an email that does not exist, the page will let you know. I believe this is implemented pretty well except for the obviously lacking password field which I'm sure will be added in the future.

**Post**: A user can make a post from the post index page. If they are logged in, they will see a "New Post" button which brings them to a form to create a new post. Once they create it, and are logged in and viewing it, they can also click "Edit" to change the post. These are implemented well since they have a time stamp, edit, title, description, etc. They also are shown in preview form on a user's profile page where a user can click "Read more". Posts are viewable by anyone but perhaps in the future they should have an option to be shown only to followers. 

##### Academic Reference

I read this blog post when considering how to model the relationships: https://www.railstutorial.org/book/following_users


# Microblog

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
