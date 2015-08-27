locker = $('.locker-container')

interacData = new class
    dial: null
    mouseDown: false
    angle: 0
    factor: 2
    acc: 0
    whichDial: ->
        @dial
    setDial: (@dial)->
    rotate: =>
        return if !@dial
        return if !@mouseDown and @acc is 0
        if !@mouseDown
            if -5 < @acc < 5
                @acc = 0
            else if @acc > 0
                @acc -=  5
            else if @acc < 0
                @acc += 5
        @angle = @angle - @factor*@acc
        @dial.css
            '-webkit-transform' : "rotate(#{@angle}deg)"
            '-moz-transform' : "rotate(#{@angle}deg)"
            '-ms-transform' : "rotate(#{@angle}deg)"
            'transform' : "rotate(#{@angle}deg)"

locker.on 'mousedown', (ev)->
    ev.preventDefault()
    _this = this
    lastKnown = null
    interacData.setDial $ @
    interacData.mouseDown = true
    $(document).on 'mousemove', (e)->
        e.preventDefault()
        if lastKnown
            if e.pageX < lastKnown.x
                interacData.acc += 0.7
            else
                interacData.acc -= 0.7
                
        lastKnown = {x: e.pageX}

$(document).on 'mouseup', (e)->
    e.preventDefault()
    interacData.mouseDown = false
    $(document).off 'mousemove'
    
setInterval interacData.rotate, 200