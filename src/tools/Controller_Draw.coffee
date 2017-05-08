###
 * Drawing Controller for Future Dystopia Project.
 *
 * Adapted by Bryce Summers on 4.15.2017
 * 
 * This class renders the current state of the game as represented in the passed in state controller.
###

class FDP.Controller_Draw

    # BDS.G_Canvas, Controller_State.
    constructor: (@_G_Canvas, @state) ->

        @_active = true

        @_grid_size = 16

        # The background image
        @background = null


        # Logic for the center text displays.
        @background_color = null
        @background_alpha = 1.0
        @background_target_alpha = 1.0

        @center_text_message = null
        @center_text_color = null

        @transition_speed = .01

    setActive: (isActive) ->

        @_active = isActive

    isActive: () ->

        return @_active

    mouse_down: (event) ->


    mouse_up: (event) ->

    # Maybe I can put in some feedback here, such as the face that the mouse is in,
    # but for now I'll allow for the tools to do that.
    mouse_move: (event) ->

    # Difference in time between the previous call and this call.
    time: (dt) ->

        # Clear the screen for new drawing.
        @_G_Canvas.clearScreen()

        # Draw the boundary lines of the screen.

        if @background != null
            @_G_Canvas.drawImage(@background, 0, 0)

        if @background_alpha != null
            @_G_Canvas.setAlpha(@background_alpha)
        if @background_color != null
            @_G_Canvas.fillColor(@background_color.toInt())
            @_G_Canvas.fillScreen()

            if @center_text_message
                @_G_Canvas.fillColor(@center_text_color.toInt())
                @_G_Canvas.centerAlignFont()
                @_G_Canvas.setFont("Verdana", 40)
                @_G_Canvas.drawText(@center_text_message, @_G_Canvas.w/2, @_G_Canvas.h/2)

        @background_alpha = (1.0 - @transition_speed)*@background_alpha + @transition_speed*@background_target_alpha

        @_G_Canvas.setAlpha(1.0)

        ###
        for r in [0 ... @state.h]
            for c in [0 ... @state.w]
                color = @state.readGrid(r, c, null)
                @drawGridSquare(r, c, color)
        ###

        # FIXME: Draw the array state.

    drawGridSquare: (r, c, color) ->

        x0 = c*16
        x1 = x0 + 16# - 1

        y0 = r*16       
        y1 = y0 + 16# - 1

        pts = [new BDS.Point(x0, y0), new BDS.Point(x1, y0),
               new BDS.Point(x1, y1), new BDS.Point(x0, y1)]

        polyline = new BDS.Polyline(true, pts)

        @_G_Canvas.fillColor(color.toInt())
        @_G_Canvas.setAlpha(.5)
        @_G_Canvas.drawPolygon(polyline, false, true)
        @_G_Canvas.setAlpha(1.0)

    window_resize: (event) ->

    # Set the background image.
    backgroundImage: (img) ->
        @background = img

    # Mono Colors the background.
    # user sets the color using setFillColor() before hand.
    # FDP.Color, float (optional)
    # The color of the background, and the alpha value that we will interpoplate the program to.
    backgroundMono: (color, target_alpha, transition_speed) ->
        @background_color = color       
        @background_target_alpha = target_alpha
        @transition_speed = transition_speed

        if not transition_speed
            @transition_speed = .01
        return

    centerMessage: (text, color) ->
        @center_text_message = text
        @center_text_color = color
        return