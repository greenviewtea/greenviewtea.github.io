window.smoothScrollTo = (target_id, duration=1000) ->
  step = ->
    factor = (Date.now() - start) / duration # get interpolation factor
    if factor >= 1
      clearInterval timer # stop animation
      factor = 1 # clip to max 1.0
    y = factor * delta + offset
    window.scrollBy 0, y - window.pageYOffset
  target = document.getElementById(target_id).offsetTop
  offset = window.pageYOffset
  delta = target - window.pageYOffset
  start = Date.now()
  factor = 0
  clearInterval timer  if timer
  timer = setInterval(step, 10)
