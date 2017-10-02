defmodule MicroblogWeb.Helpers do
    import Ecto.Query, warn: false
    alias Microblog.Accounts.Relationship

    # def user_has_posts(%User{} = user) do
    #     u = Microblog.Repo.preload(user, :posts)
    #     length(u.posts) > 0
    # end
    #
    # def get_posts(%User{} = user) do
    #     u = Microblog.Repo.preload(user, :posts)
    #     u.posts
    # end
    #
    # def make_relationship_params(actor_id, receiver_id) do
    #     defstruct [actor_id: actor_id, receiver_id: receiver_id]
    # end

    def is_following?(actor_id, receiver_id) do
        # r = %Relationship{actor_id: actor_id, receiver_id: receiver_id}
        # Repo.get(Relationship, r) == nil

        re = get_relationship(actor_id, receiver_id)
        length(re) > 0
    end

    def get_relationship(actor_id, receiver_id) do
        Microblog.Repo.all(
          from r in "relationships",
          where: r.actor_id == ^actor_id and r.receiver_id == ^receiver_id,
          select: r
         )
    end
end
