defmodule Pento.Testna do
import Ecto.Query, warn: false
alias Pento.Repo
alias Pento.Testna.Test

def list_tests do
    Repo.all(Test)
  end

end