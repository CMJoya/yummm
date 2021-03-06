require "test_helper"

class CreateRecipeTest < Capybara::Rails::TestCase

  setup do
    Category.create! name: "delicious tacos"
    User.create! name: "Bob", email: "bob@example.com", password: "12345678"

  end

  # test "can create a recipe" do
  scenario "can create a recipe", js: true do

    visit root_path
    click_link "All Recipes"

    fill_in :email, with: "bob@example.com"
    fill_in :password, with: "12345678"
    click_button "Sign In"

    click_link "All Recipes"
    click_link "add"


    within("#new_recipe") do
      fill_in "Name", with: "Tacos"
      fill_in "Ingredients", with: "The Ingredients"
      fill_in "Method", with: "The Method"
      fill_in "Description", with: "The Description"

      select("delicious tacos", from: "Category")
      #attach_file('Photo', "#{Rails.root}/test/fixtures/tacos.jpg")
      fill_in "Photo Url", with: "http://tacospin.com/assets/img/taco.jpg"
      click_button "Create Recipe"
    end

    ## Assert that this passed
    # 1. visit recipes_path and check if "Tacos"
    # 2. Recipe.find_by name: "Tacos"

    visit recipes_path
    assert_content page, "Tacos"

  end

end
