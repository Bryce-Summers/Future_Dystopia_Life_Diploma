###
 * Drawing Controller for Future Dystopia Project.
 *
 * Adapted by Bryce Summers on 4.15.2017
 * 
 * This class renders the current state of the game as represented in the passed in state controller.
###

class FDP.Controller_State

    # BDS.G_Canvas, Controller_State.
    constructor: () ->

        # Signals whether or not this state is updating.
        @_active = true

        @grid = [];
        @grid_temp = [];

        @w = 75;
        @h = 50;

        for r in [0...@w] by 1
            for c in [0...@h] by 1
                @grid.push(new FDP.Color(1.0, 1.0, 1.0)) # red.

                # Another grid.
                @grid_temp.push(new FDP.Color(1.0, 0, 0))

        @mouse_r = 0
        @mouse_c = 0
        @_grid_size = 16

    # mode = clamp, wrap, etc.
    # grid row index, column index.
    # interpolates if the given indices are floats, rather than integers.
    # (number, number, ENUM Mode) -> FDP.Color
    readGrid: (r, c, mode) ->

        # 2D --> 1D grid packing.
        index = @_rc_to_index(r, c)
        return @grid[index]
        

    setGrid: (r, c, color, mode) ->

        index = @_rc_to_index(r, c)

        return @grid[index] = color

    setActive: (isActive) ->

        @_active = isActive


    isActive: () ->

        return @_active


    mouse_down: (event) ->

    mouse_up: (event) ->


    # Maybe I can put in some feedback here, such as the face that the mouse is in,
    # but for now I'll allow for the tools to do that.
    mouse_move: (event) ->

        @mouse_r = (Math.floor(event.y / @_grid_size) + @h*10) % @h
        @mouse_c = (Math.floor(event.x / @_grid_size) + @w*10) % @w


    # Difference in time between the previous call and this call.
    time: (dt) ->

        # Constant Lighting.
        @setGrid(@mouse_r, @mouse_c, new FDP.Color(0, 0, 0), null)

        # Update the visual Radiosity Array.
        for index in [0...@grid.length]


            r = @_index_to_row(index)
            c = @_index_to_col(index)

            r_up   = (r + @h - 1) % @h
            r_down = (r + 1) % @h

            c_left  = (c + @w - 1) % @w
            c_right = (c + 1) % @w

            color = @readGrid(r, c)

            color_left  = @readGrid(r, c_left)
            color_right = @readGrid(r, c_right)
            color_up    = @readGrid(r_up,   c)
            color_down  = @readGrid(r_down, c)

            color_new = color_left.multScalar(.2).add(
                    color_right.multScalar(.2)).add(
                    color_up.multScalar(.2)).add(
                    color_down.multScalar(.2)).add(
                    color.multScalar(.2))

            @grid_temp[index] = color_new

        # Change the old grid for the new temporary grid.
        @_swapGrids()


    _index_to_row: (index) ->
        return Math.floor(index / @w)

    _index_to_col: (index) ->
        return index % @w

    _rc_to_index: (r, c) ->
        row_start_index = @w*r
        return row_start_index + c

    _swapGrids: () ->
        temp       = @grid
        @grid      = @grid_temp
        @grid_temp = temp


    window_resize: (event) ->