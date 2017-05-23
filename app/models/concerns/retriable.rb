module Retriable
  extend ActiveSupport::Concern

  class_methods do
    def find_or_create_by_retry(*args, &block)
      begin
        transaction(requires_new: true) do
          find_or_create_by(*args, &block)
        end
      rescue ActiveRecord::RecordNotUnique
        retry
      end
    end
  end
end
