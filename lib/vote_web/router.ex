defmodule VoteWeb.Router do
  use VoteWeb, :router

  import VoteWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {VoteWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VoteWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/candidates", CandidateLive.Index, :index
    live "/candidates/new", CandidateLive.Index, :new
    live "/candidates/:id/edit", CandidateLive.Index, :edit

    live "/candidates/:id", CandidateLive.Show, :show
    live "/candidates/:id/show/edit", CandidateLive.Show, :edit

    live "/ballot_cast", Ballot_CastLive.Index, :index
    live "/ballot_cast/:id", Ballot_CastLive.Index, :index

    live "/ballot_items", Ballot_ItemLive.Index, :index
    live "/ballot_items/new", Ballot_ItemLive.Index, :new
    live "/ballot_items/:id/edit", Ballot_ItemLive.Index, :edit

    live "/ballot_items/:id", Ballot_ItemLive.Show, :show
    live "/ballot_items/:id/show/edit", Ballot_ItemLive.Show, :edit

    live "/elections", ElectionLive.Index, :index
    live "/elections/new", ElectionLive.Index, :new
    live "/elections/:id/edit", ElectionLive.Index, :edit

    live "/elections/:id", ElectionLive.Show, :show
    live "/elections/:id/show/edit", ElectionLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", VoteWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VoteWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", VoteWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", VoteWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings/update_password", UserSettingsController, :update_password
    put "/users/settings/update_email", UserSettingsController, :update_email
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", VoteWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
