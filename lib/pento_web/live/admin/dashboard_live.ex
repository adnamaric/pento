defmodule PentoWeb.Admin.DashboardLive do
    use PentoWeb, :live_view
    #alias PentoWeb.{SurveyResultsLive, UserActivityLive, ProductSalesLive}
    alias PentoWeb.Endpoint

    @survey_results_topic "survey_results"
    @user_activity_topic "user_activity"
 
    
    def mount(_params, _session, socket) do
    
      {:ok,
       socket
       |> assign(:survey_results_component_id, "survey-results")
       |> assign(:user_activity_component_id, "user-activity")}
    end
    
    def handle_info(%{event: "presence_diff"}, socket) do
      send_update(
      UserActivityLive,
      id: socket.assigns.user_activity_component_id)
      {:noreply, socket}
      end
  end