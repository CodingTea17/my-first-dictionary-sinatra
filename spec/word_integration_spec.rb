
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('word addition success', {:type => :feature}) do
  it('processes the user entry and adds the first word to the dictionary') do
    visit('/')
    fill_in('new_word', :with => 'Sushi')
    click_button('add')
    expect(page).to have_content('Sushi')
  end
end
describe('word addition failure', {:type => :feature}) do
  it('processes the user entry and lets the user know a word has already been added') do
    visit('/')
    fill_in('new_word', :with => 'Sushi')
    click_button('add')
    fill_in('new_word', :with => 'Sushi')
    click_button('Add it to your dictionary')
    expect(page).to have_content('it already exists')
  end
end
describe('defintion addition success', {:type => :feature}) do
  it('processes the user entry and adds a definition for a given word') do
    visit('/')
    fill_in('new_word', :with => 'Sushi')
    click_button('add')
    click_link('Sushi')
    fill_in('new_definition', :with => 'A delicious meal typically involving rice, nori, and raw fish')
    click_button('Add this definition!')
    expect(page).to have_content('A delicious meal typically involving rice, nori, and raw fish')
  end
end
describe('defintion addition failure', {:type => :feature}) do
  it('processes the user entry and lets the user know if their definition is empty') do
    visit('/')
    fill_in('new_word', :with => 'Sushi')
    click_button('add')
    click_link('Sushi')
    fill_in('new_definition', :with => '')
    click_button('Add this definition!')
    expect(page).to have_content('No definition was given')
  end
end
describe('list all', {:type => :feature}) do
  it('loads a page with all the words and definitions the user has added') do
    visit('/')
    fill_in('new_word', :with => 'Sushi')
    click_button('add')
    fill_in('new_word', :with => 'Yellow Curry')
    click_button('Add it to your dictionary')
    click_link('Sushi')
    fill_in('new_definition', :with => 'A delicious meal typically involving rice, nori, and raw fish')
    click_button('Add this definition!')
    visit('/dictionary')
    click_link('Yellow Curry')
    fill_in('new_definition', :with => 'A delicious meal typically curry powder, chicken, potatoes, carrots, and coconut milk')
    click_button('Add this definition!')
    visit('/dictionary')
    click_link('list')
    expect(page).to have_content('chicken') and have_content ('rice') and have_content ('Yellow Curry') and have_content ('Sushi')
  end
end
