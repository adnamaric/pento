# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


products = [
%{
    name: "Chess",
    description: "The classic strategy game",
    sku: 5_678_910,
    unit_price: 10.00
},
%{
    name: "Tic-Tac-Toe",
    description: "The game of Xs and Os",
    sku: 11_121_314, unit_price: 3.00
},
%{
    name: "Table Tennis",
    description: "Bat the ball back and forth. Don't miss!",
    sku: 15_222_324,
    unit_price: 12.00
}
]

accounts =
[ %{
    email: "test@test.io",
    is_admin: true,
    password: "X5LfaMBkbj3CN9F"
   },
   %{
    email: "test1@test.io",
    is_admin: false,
    password: "X5LfaMBkbj3CN9F"
   }
]
demographics = [
    %{       
        gender: "female",
        id: 1,
        user_id: 1,
        year_of_birth: 1997
    },
    %{       
        gender: "male",
        id: 2,
        user_id: 2,
        year_of_birth: 1998
    }
]
ratings = [
    %{
        id: 1,
        product_id: 1,
        stars: 3,
        user_id: 1
    },
    %{
        id: 2,
        product_id: 2,
        stars: 4,
        user_id: 1
    },
    %{
        id: 3,
        product_id: 3,
        stars: 4,
        user_id: 1
    },
    %{
        id: 4,
        product_id: 1,
        stars: 4,
        user_id: 2
    },
    %{
        id: 5,
        product_id: 2,
        stars: 2,
        user_id: 2
    },
    %{
        id: 6,
        product_id: 3,
        stars: 5,
        user_id: 2
    },
]
Enum.each(accounts,fn account -> 
    Pento.Accounts.register_user(account)
end )
Enum.each(products, fn product -> 
   Pento.Catalog.create_product(product)
end)
Enum.each(demographics, fn demographic -> 
    Pento.Survey.create_demographic(demographic)
 end)
Enum.each(ratings, fn rating -> 
 Pento.Survey.create_rating(rating)
end)