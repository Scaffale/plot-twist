class ChoosenResult < ApplicationRecord
  def new_name(*_args)
    uniq_id
  end
end
