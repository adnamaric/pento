defmodule PentoWeb.Pento.GameLive do
    use PentoWeb, :live_view
  
    alias PentoWeb.Pento.Board
  
    def mount(%{"puzzle" => puzzle}, _session, socket) do
        IO.inspect socket
      {:ok, assign(socket, puzzle: puzzle)}
    end
  
    def render(assigns) do
    ~H"""
      
      <section class="pento">
        <h1 >Welcome to Pento!</h1>
        <h2>Switch size of board:</h2>
        <%= if assigns.puzzle=="default" do %>
          <style>
          #default{
            background-color:white; color:#663399; border:0.1rem solid #663399
          }
      </style>
       
        <% end %>
        <%= if assigns.puzzle !== "default" do %>
        <style>
        #default{
      
          background-color:#663399; color:white; border:0.1rem solid #663399
        }
        
      </style>

       <% end %>
       <%= if assigns.puzzle=="tiny" do %>
       <style>
       #tiny{
         background-color:white; color:#663399; border:0.1rem solid #663399
       }
   </style>
    
     <% end %>
     <%= if assigns.puzzle !== "tiny" do %>
     <style>
     #tiny{
   
       background-color:#663399; color:white; border:0.1rem solid #663399
     }
     
   </style>

    <% end %>
    <%= if assigns.puzzle=="medium" do %>
    <style>
    #medium{
      background-color:white; color:#663399; border:0.1rem solid #663399
    }
    </style>
    
      <% end %>
      <%= if assigns.puzzle !== "medium" do %>
      <style>
      #medium{

        background-color:#663399; color:white; border:0.1rem solid #663399
      }
      
    </style>

    <% end %>
    <%= if assigns.puzzle=="wide" do %>
    <style>
    #wide{
      background-color:white; color:#663399; border:0.1rem solid #663399
    }
    </style>

    <% end %>
    <%= if assigns.puzzle !== "wide" do %>
    <style>
    #wide{

    background-color:#663399; color:white; border:0.1rem solid #663399
    }

    </style>

    <% end %>
    <%= if assigns.puzzle=="widest" do %>
    <style>
    #widest{
      background-color:white; color:#663399; border:0.1rem solid #663399
    }
    </style>

    <% end %>
    <%= if assigns.puzzle !== "widest" do %>
    <style>
    #widest{

    background-color:#663399; color:white; border:0.1rem solid #663399
    }

    </style>

    <% end %>
        <button class="bttn" id="default" data-method="get" data-to="/game/default">DEFAULT</button>
        <button class="bttn" id="tiny" data-method="get" data-to="/game/tiny">TINY</button>
        <button class="bttn" id="medium" data-method="get" data-to="/game/medium">MEDIUM</button>
        <button class="bttn" id="wide" data-method="get" data-to="/game/wide">WIDE</button>
        <button class="bttn" id="widest"  data-method="get" data-to="/game/widest">WIDEST</button>
        <br><br>
        <h2>Instructions:</h2>
        <h3 >Pick a pentomino and and position it on board with following commands on keyboard (↑, ↓, →, ←). Flip with key enter ( ↵) on keyboard. Rotate the pentomino with (⇧) shift command on keyboard.  In order to lock position of pentonimo on board, you need to click (⎵) space bar command on keyboard. For a removal, you need to click on pentomino on board. </h3>
     
        </section>
        <.live_component module={Board} puzzle={ @puzzle } id="game" />
        

  

      """
    end
  end