require 'rails_helper'

describe 'Draft form accordions', js: true do
  before do
    login
    draft = create(:draft, user: User.where(urs_uid: 'testuser').first)
    visit draft_path(draft)
  end

  context 'when clicking on the header' do
    before do
      click_on 'Distribution Information'

      # Open the RelatedUrl fieldset accordion
      all('fieldset.eui-accordion > div.eui-accordion__header').first.click

      # Collapse the Related Url 1 accordion
      find('.multiple.related-urls > .multiple-item-0 > .eui-accordion__header').click
    end

    it 'collapses the accordion' do
      expect(page).to have_css('.multiple-item-0.is-closed')
    end

    it 'hides the fields' do
      expect(page).to have_no_field('Description')
    end

    context 'when clicking on the header again' do
      before do
        # Open the Related Url 1 accordion
        find('.multiple.related-urls > .multiple-item-0.is-closed > .eui-accordion__header').click
      end

      it 'opens the accordion' do
        expect(page).to have_no_css('.multiple-item-0.is-closed')
      end

      it 'shows the fields' do
        expect(page).to have_field('Description')
      end
    end
  end

  context 'when viewing a form with only one accordion' do
    before do
      within '.metadata' do
        click_on 'Organization', match: :first
      end
    end

    it 'shows the accordion open by default' do
      expect(page).to have_no_css('.eui-accordion.is-closed')
    end

    context 'when clicking on the accordion header' do
      before do
        first('.eui-accordion__header').click
        sleep 0.5
      end

      it 'does not allow the user to collapse the accordion' do
        expect(page).to have_selector('#draft_organizations_0_role', visible: true)
      end
    end
  end

  context 'when clicking a help icon within the accordion header' do
    before do
      click_on 'Distribution Information'
      click_on 'Help modal for Distributions'
    end

    it 'displays the help text' do
      within '#help-modal' do
        expect(page).to have_content('Distributions')
      end
    end

    it 'does not open the accordion' do
      expect(page).to have_no_field('DistributionMedia')
    end
  end
end
