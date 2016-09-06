class AddLengthToAnagram < ActiveRecord::Migration[5.0]
  def change
    add_column :anagrams, :length, :integer, null: false
  end
end
