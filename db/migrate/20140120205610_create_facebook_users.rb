class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
    	t.string :name
    	t.string :image_url
    	t.string :identity
      t.timestamps
    end
  end
end
