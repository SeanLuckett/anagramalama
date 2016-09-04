class CreateAnagrams < ActiveRecord::Migration[5.0]
  def change
    create_table :anagrams do |t|
      t.string :word
      t.string :sorted_word, null: false

      t.timestamps
    end

    add_index :anagrams, :sorted_word
  end
end
