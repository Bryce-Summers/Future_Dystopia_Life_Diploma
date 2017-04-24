###
 * Story Controller for Future Dystopia Project.
 *
 * Written by Bryce Summers on Apr.24.2017
 * 
 * This class handles the button and Story text update logic throughout the game.
 * Note: Dimensions of room are 1200px by 800 px.
###

class FDP.Controller_Story

    # BDS.G_Canvas, Controller_State.
    constructor: (@ui) ->

        @_active = true
        
        
        # We put the line drawing button first to encourage people to use it.

        @p_left  = @newCircle(200, 400)
        @p_right = @newCircle(1000, 400)
        @p_up    = @newCircle(600, 200)
        @p_down  = @newCircle(600, 600)
        @p_mid   = @newCircle(600, 400)

        @buttons = []

        @advance_func = @click(@)

        # Generate the entire story.
        @make_story()

        # Advance the story to the first element.
        @advance_func()

    # Transition function.
    click: (self) ->
        () ->
            
            play(sounds.button)


            for b in self.buttons
                self.removeButton(b)

            # End of story.
            if self.story_index >= self.story.length
                return

            # Populate the Game with the current story state.
            story = self.story[self.story_index]
            self.story_index += 1 # move on the the next story element.

            if story.mid # Story.mid provides the image file.
                img = story.mid
                pline = self.p_mid    
                b = self.ui.createButton(pline, self.advance_func, img)
                self.buttons.push(b)

            if story.left # Story.mid provides the image file.
                img = story.left
                pline = self.p_left
                b = self.ui.createButton(pline, self.advance_func, img)
                self.buttons.push(b)            
            
            if story.right # Story.mid provides the image file.
                img = story.right
                pline = self.p_right
                b = self.ui.createButton(pline, self.advance_func, img)
                self.buttons.push(b)

            if story.up # Story.up provides the image file.
                img = story.up
                pline = self.p_up
                b = self.ui.createButton(pline, self.advance_func, img)
                self.buttons.push(b)

            if story.down # Story.down provides the image file.
                img = story.down
                pline = self.p_down
                b = self.ui.createButton(pline, self.advance_func, img)
                self.buttons.push(b)

            if story.header
                header.innerHTML = story.header

            if story.statement
                instructions.innerHTML = story.statement


    make_story: () ->

        @story = []
        @story_index = 0


        s_birth = {mid:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {left:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {up:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {down:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {right:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)


        @story.push({mid:img_study
                   ,up:img_play
                   ,down:img_dream,
                   header:"",
                   statement: ""})

        @story.push({up:img_college
                    ,mid:img_work
                    #down:img_dream,
                    ,header:""
                    ,statement: ""})

        # FIXME: Add branching narratives, look in sketchbook for story plan.
        @story.push({up:img_think
                    ,mid:img_follow
                    ,down:img_work
                    ,header:""
                    ,statement: ""})

        @story.push({up:img_scientist
                    ,mid:img_artist
                    ,down:img_inventor
                    ,header:""
                    ,statement: ""})

        @story.push({up:img_think
                    ,mid:img_learn
                    ,down:img_worry
                    ,header:""
                    ,statement: ""})

        ###
        @story.push({mid:img_age
                    ,header:""
                    ,statement: ""})
        ###



    newCircle: (x, y) ->
        pts = []
        for i in [0...Math.PI*2] by Math.PI/100
        
            cx     = x
            cy     = y
            radius = 48

            pts.push(new BDS.Point(cx + radius*Math.cos(i), cy + radius*Math.sin(i)))

        return new BDS.Polyline(true, pts, true)

    removeButton: (b) ->
        @ui.removeButton(b)

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

    window_resize: (event) ->