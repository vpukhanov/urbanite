require 'rails_helper'

RSpec.describe "Term Lookups", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:sample_definition) do
    [ {
      'word' => 'example',
      'definition' => 'This is a sample definition.',
      'example' => 'This is a sample example.',
      'author' => 'Test Author'
    } ]
  end

  before do
    allow(UrbanDictionaryService).to receive(:define).and_return(sample_definition)
  end

  it "allows a user to look up a term" do
    visit root_path

    fill_in "term", with: "example"
    click_button "Define"

    expect(page).to have_content("example")
    expect(page).to have_content("This is a sample definition.")
  end

  it "shows a not found page for non-existent terms" do
    allow(UrbanDictionaryService).to receive(:define).and_raise(UrbanDictionaryService::NotFoundError)

    visit root_path
    fill_in "term", with: "nonexistentterm"
    click_button "Define"

    expect(page).to have_content("Term Not Found")
    expect(page).to have_content("nonexistentterm")
    expect(page).not_to have_field("term")
  end

  it "allows navigation back to search from definition page" do
    visit term_path("example")

    click_link "Search"

    expect(current_path).to eq(root_path)
  end
end
