describe 'Viewing Unsubmitted Collection Draft Proposals', js: true do
  before do
    login
    set_as_proposal_mode_mmt
  end

  context 'when viewing the metadata' do
    before do
      draft = create(:full_collection_draft_proposal, draft_short_name: 'An Example Proposal', version: '5', draft_entry_title: 'An Example Proposal Title')
      visit collection_draft_proposal_path(draft)
    end

    it 'displays the current proposal status' do
      expect(page).to have_content('Proposal Status: In Work')
    end

    it 'has a submit button' do
      expect(page).to have_link('Submit for Review')
      click_on('Submit for Review')
      expect(page).to have_content('Are you sure you want to submit this proposal?')
    end

    it 'has a delete link' do
      expect(page).to have_link('Delete Collection Draft Proposal')
    end
  end

  context 'when viewing incomplete metadata' do
    before do
      draft = create(:empty_collection_draft_proposal)
      visit collection_draft_proposal_path(draft)
    end

    it 'cannot be submitted yet' do
      click_on('Submit for Review')
      expect(page).to have_content('This proposal is not ready to be submitted. Please use the progress indicators on the proposal preview page to address incomplete or invalid fields.')
    end
  end
end