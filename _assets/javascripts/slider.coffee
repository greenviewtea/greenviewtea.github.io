image_number = 0
slider_width = 0
current = 0
image_width = 0
li_number = 0
ul = null

initSlider = ->
  ul = document.getElementById "image_slider"
  li_items = ul.children
  li_number = li_items.length
  i = 0
  while i < li_number
    # nodeType == 1 means the node is an element.
    # in this way it's a cross-browser way.
    #if (li_items[i].nodeType == 1){
    #clietWidth and width???
    image_width = li_items[i].clientWidth
    slider_width += image_width
    image_number++
    i++
  ul.style.width = parseInt(slider_width) + "px"
  slider ul

slider = ()->
  animate
    delay: 17
    duration: 3000
    delta: (p) ->
      Math.max 0, -1 + 2 * p

    step: (delta) ->
      ul.style.left = "-" + parseInt(current * image_width + delta * image_width) + "px"

    callback: ->
      current++
      if current < li_number - 1
        slider()
      else
        left = (li_number - 1) * image_width
        setTimeout (->
          goBack left
        ), 2000
        setTimeout slider, 4000

goBack = (left_limits) ->
  current = 0
  setInterval (->
    if left_limits >= 0
      ul.style.left = "-" + parseInt(left_limits) + "px"
      left_limits -= image_width / 10
  ), 17

animate = (opts) ->
  start = new Date
  id = setInterval(->
    timePassed = new Date - start
    progress = timePassed / opts.duration
    progress = 1  if progress > 1
    delta = opts.delta(progress)
    opts.step delta
    if progress is 1
      clearInterval id
      opts.callback()
  , opts.dalay or 17)

window.onload = initSlider
