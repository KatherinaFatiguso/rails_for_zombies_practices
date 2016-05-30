class RemoveAgeFromZombies < ActiveRecord::Migration
  def up
    remove_column :zombies, :age
  end

  def down #run with rollback, this will execute if you rollback the Migration
    add_column :zombies, :age, :integer
  end
end
