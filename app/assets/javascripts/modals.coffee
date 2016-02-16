$(document).ready ->

  $('.display-modal').leanModal
    top: 200
    overlay: 0.6
    closeButton: '.modal-close'

  # Handle not-current-provider-modal
  $('a.not-current-provider').on 'click', (element) ->
    provider = $(element.target).data('provider')
    action = $(element.target).data('recordAction')

    $modal = $('#not-current-provider-modal')
    $link = $modal.find('a.not-current-provider-link')
    $link.data('provider', provider)

    textAction = switch action
      when 'edit-collection'
        'Editing this collection'
      when 'clone'
        'Cloning this collection'
      when 'delete-collection'
        'Deleting this collection'
      when 'Reinstate'
        action = 'revert'
        'Reinstating this collection'
      when 'Revert to this Revision'
        action = 'revert'
        'Reverting this collection'
      when 'edit-draft'
        'Editing this draft'

    $link.data('type', action)
    $modal.find('span.provider').text(provider)
    $modal.find('span.record-action').text(textAction)

  $('a.not-current-provider-link').on 'click', (element) ->
    provider = $(element.target).data('provider')
    linkType = $(element.target).data('type')

    $.ajax
      url: "/set_provider?provider_id=#{provider}"
      method: 'post'
      dataType: 'json'
      success: (data, status, xhr) ->
        # Click the link that the user needs
        $("#not-current-provider-#{linkType}-link")[0].click()
