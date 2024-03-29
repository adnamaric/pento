defmodule PentoWeb.Router do
  use PentoWeb, :router

  import PentoWeb.UserAuth
 

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PentoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug NavigationHistory.Tracker
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

   scope "/", PentoWeb do
    pipe_through [:browser]
   
    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
    get "/login", UserSessionController, :new
    live "/game/:puzzle", Pento.GameLive

   end

  
  scope "/", PentoWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", PageLive, :index
    #live "/guess", WrongLive
    get "/users/settings", UserSettingsController, :edit
    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit

  end
 
 
  scope "/", PentoWeb do
  pipe_through [:browser, :require_authenticated_user]
  live_session :default, on_mount: PentoWeb.UserAuthLive do
    live "/guess", WrongLive
    live "/survey", SurveyLive, :index
    live "/promo", PromoLive
    live "/products/:id", ProductLive.Show, :show
    end
  end

  scope "/", PentoWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/questions", QuestionLive.Index, :index
    live "/questions/new", QuestionLive.Index, :new
    live "/questions/:id/edit", QuestionLive.Index, :edit

    live "/questions/:id", QuestionLive.Show, :show
    live "/questions/:id/show/edit", QuestionLive.Show, :edit
    live "/answers", AnswerLive.Index, :index
    live "/answers/new", AnswerLive.Index, :new
    live "/answers/:id/edit", AnswerLive.Index, :edit

    live "/answers/:id", AnswerLive.Show, :show
    live "/answers/:id/show/edit", AnswerLive.Show, :edit
    
  

  end
  # Other scopes may use custom stacks.
  # scope "/api", PentoWeb do
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
      live_dashboard "/dashboard", metrics: PentoWeb.Telemetry
      get "/users/settings", UserSettingsController, :edit
    end
  end

  ## Authentication routes

  scope "/", PentoWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

  

  end
  
  scope "/", PentoWeb do
    pipe_through [:browser, :require_authenticated_user ]
    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

   
   scope "/", PentoWeb do
    pipe_through [:browser, :require_authenticated_admin]
   
   live "/game-sales", Admin.GameSalesLive
    live "/survey-results", Admin.SurveyResultsLive
    # other admin routes
    live "/admin-dashboard", Admin.DashboardLive
   end

  scope "/", PentoWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
