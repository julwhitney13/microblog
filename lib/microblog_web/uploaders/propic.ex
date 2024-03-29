defmodule Microblog.Propic do
  use Phoenix.Endpoint, otp_app: :microblog
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  def __storage, do: Arc.Storage.Local

  # @versions [:original, :thumb]
  @versions [:original]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end

  # Override the persisted filenames:
  def filename(version, {file, scope}) do
    "#{version}_#{file.file_name}"
  end

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "priv/static/images/propics/"
  # end

  # def storage_dir(_version, {_file, scope}) do
  #   # Application.get_env(:arc, :storage_dir) <> "uploads/#{scope.id}"
  #   if Application.get_env(:microblog, :environment) == :prod do
  #       "priv/static/propics/"
  #   else
  #       "uploads/"
  #   end
  # end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(version, scope) do
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Blank_woman_placeholder.svg/2000px-Blank_woman_placeholder.svg.png"
  end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
