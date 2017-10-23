# Kim Whitney's Microblog

### Github Repo:
https://github.com/kimception/microblog

### Deployed Application
http://www.microblog.sorryiateallyourpancakes.com/

### How to Deployed
From server, in the source directory, run './deploy.sh </output/dir/for/deploy>'. the output dir will be the dir referenced in the systemd file - so in my server's case it is '/home/microblog/microblog'

### Design Explanation

**Relationships**: When a user is logged in and viewing a single profile (/user :show) or a list of users (/user :index), there will be a follow or unfollow button. If they are currently following that user, they will only see an unfollow button. If they are not, they will only see a follow button. If the card is their profile, there obviously will not be any button. No follow or unfollow buttons are shown at all when a user is not logged in. I think this is pretty well implemented since a user has flexibility of where and when they can follow or unfollow a user. They are alerted if the action succeeded or failed and they remain on their last path.

**Login**: A user can log in at the top of the page with their email address when they are not logged in already. The nav bar will then display their username next to a logout button. They can log in or log out at any time / page. If they are not logged in, there is also a button to create an account. If a user tries to log in with an email that does not exist, the page will let you know. I believe this is implemented pretty well except for the obviously lacking password field which I'm sure will be added in the future.

**Post**: A user can make a post from the post index page. If they are logged in, they will see a "New Post" button which brings them to a form to create a new post. Once they create it, and are logged in and viewing it, they can also click "Edit" to change the post. These are implemented well since they have a time stamp, edit, title, description, etc. They also are shown in preview form on a user's profile page where a user can click "Read more". Posts are viewable by anyone but perhaps in the future they should have an option to be shown only to followers.

**Likes**: When a user is viewing a post (/show) and are logged in or not, they will see the number of likes the post has at the bottom of the post. If a user is logged in, they will see a "like" button in red if they have not liked it yet or an "unlike" button in blue if they've already liked it. When they click "Like" or "Unlike" (depending on the like state) the like counter will change accordingly and the button will change to the opposite one (Like > unlike, unlike > like). This is implemented well since it uses ajax requests to refresh these states rather than reloading the entire page or reading from the database. The user does not have the functionality of liking from the /index page since in my microblog application, you cannot read the whole post from the index page and it makes more sense for them to only be able to like or dislike it after reading it.

##### Academic Reference

- I read this blog post when considering how to model the relationships: https://www.railstutorial.org/book/following_users
- A few stack overflow posts and ajax docs were referenced in figuring out how to change the like button, but none were even close to what I ended up implementing on my own
- Referenced for channel sockets https://medium.com/elixir-magic/writing-a-blog-engine-in-phoenix-and-elixir-part-9-live-comments-9269669a6941
- Also referenced for channel sockets http://learningelixir.joekain.com/pushing-model-changes-to-a-phoenix-channel/
- Referenced portions of adding photo uploads to the app from this blog post https://medium.com/@Stephanbv/elixir-phoenix-uploading-images-locally-with-arc-b1d5ec88f7a


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
