require './noteHandle.jade'

Template.noteHandle.helpers
  count: () ->
    @rank / 2

Template.noteHandle.events
  'click .handle': (event, instance) ->
    event.preventDefault()
    event.stopImmediatePropagation()
    console.log instance
    if !Session.get 'dragging'
      title = $(instance.firstNode).parents('.noteContainer').first().find('.title')
      offset = title.offset()
      $(".mdl-layout__content").animate({ scrollTop: 0 }, 500)
      headerOffset = $('.title-wrapper').offset()
      $('.title-wrapper').fadeOut()

      $('body').append(title.clone().addClass('zoomingTitle'))
      $('.zoomingTitle').offset(offset).animate({
        left: headerOffset.left
        top: headerOffset.top
        color: 'white'
        fontSize: '20px'
      }, 100, 'swing', ->
        $('.zoomingTitle').remove()
        FlowRouter.go '/note/'+instance.data._id+'/'+(FlowRouter.getParam('shareKey')||'')
      )
