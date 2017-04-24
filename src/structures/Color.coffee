###
 * Drawing Controller for Future Dystopia Project.
 *
 * Adapted by Bryce Summers on 4.15.2017
 * 
 * This class renders the current state of the game as represented in the passed in state controller.
###

class FDP.Color

    # float, float, float [0 ... 1]
    constructor: (@r, @g, @b) ->

    toInt: () ->

        red   = Math.floor(@r*255)
        green = Math.floor(@g*255)
        blue  = Math.floor(@b*255)

        # Pack the red, green, and blue colors into an integer.
        red   = red   << 16
        green = green << 8

        return red + green + blue

    # Returns the sum of this color and the given color.
    add: (c) ->

        r = @r + c.r
        g = @g + c.g
        b = @b + c.b

        return new FDP.Color(r, g, b)

    # Returns the product of this color and given color.
    # Works best usually when both colors are in the range 0 - 1.
    mult: (c) ->

        r = @r*c.r
        g = @g*c.g
        b = @b*c.b

        return new FDP.Color(r, g, b)

    multScalar: (p) ->

        r = @r*p
        g = @g*p
        b = @b*p

        return new FDP.Color(r, g, b)