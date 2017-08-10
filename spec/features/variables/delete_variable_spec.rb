require 'rails_helper'

describe 'Delete variable', js: true do
  before do
    login
  end

  context 'when viewing a published variable' do
    before do
      ingest_response = publish_variable_draft

      visit variable_path(ingest_response['concept-id'])
    end

    it 'displays a delete link' do
      expect(page).to have_content('Delete Variable Record')
    end

    context 'when clicking the delete link' do
      before do
        click_on 'Delete Variable Record'

        within '#delete-record-modal' do
          click_on 'Yes'
        end
      end

      it 'displays a confirmation message' do
        expect(page).to have_content('Variable Deleted Successfully!')
      end

      it 'displays the manage metadata page' do
        expect(page).to have_content('MMT_2 Variable Drafts')
      end
    end
  end
end
