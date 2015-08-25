locker = $('.locker-container')

interacData = new class
    dial: null
    mouseDown: false
    angle: 0
    factor: 2
    whichDial: ->
        @dial
    setDial: (@dial)->
    rotateToLeft: ->
        @angle = @angle - @factor
        console.log(@angle, @factor);
        @dial.css
            '-webkit-transform' : "rotate(#{@angle}deg)"
            '-moz-transform' : "rotate(#{@angle}deg)"
            '-ms-transform' : "rotate(#{@angle}deg)"
            'transform' : "rotate(#{@angle}deg)"
    rotateToRight: ->
        @angle = @angle + @factor
        console.log(@angle, @factor);
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
                do interacData.rotateToLeft
            else
                do interacData.rotateToRight
                
        lastKnown = {x: e.pageX}

$(document).on 'mouseup', (e)->
    e.preventDefault()
    interacData.setDial null
    interacData.mouseDown = false
    $(document).off 'mousemove'