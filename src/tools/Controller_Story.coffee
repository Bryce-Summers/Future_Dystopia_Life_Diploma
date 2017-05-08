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
    constructor: (@ui, @draw) ->

        @_active = true
        
        # We put the line drawing button first to encourage people to use it.

        @p_left  = @newCircle(200, 700)
        @p_mid   = @newCircle(600, 700)
        @p_right = @newCircle(1000,700)



        @p_up    = @newCircle(600, 200)
        @p_down  = @newCircle(600, 600)
        
        @current_narrative_audio = null


        @buttons = []

        @advance_func = @click(@)

        # A timer until we transition to the next story state.
        @time_left = null


        @total_time = 0.0

        #--------------------------------------------------------
        # Don't initialize variables under this line,
        # because they will overwirte the initial story commands.
        #--------------------------------------------------------

        # Generate the entire story.
        @make_story()

        # Advance the story to the first element.
        @advance_func()


    # Transition function.
    click: (self) ->
        () ->
            
            #play(sounds.button)


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


            if story.audio
                if self.current_narrative_audio != null
                    self.current_narrative_audio.pause()
                if story.audio != null
                    play(story.audio)
                    self.current_narrative_audio = story.audio

            # Null goes to a null background.
            if story.background
                self.draw.backgroundImage(story.background)

            if story.center_text
                alpha = 1.0
                if story.center_target_alpha
                    alpha = story.center_target_alpha

                transition_speed = .01
                if story.transition_speed
                    transition_speed = story.transition_speed

                self.draw.backgroundMono(new FDP.Color(0.0, 0, 0), alpha, transition_speed)
                self.draw.centerMessage(story.center_text, new FDP.Color(1, 1, 1))
            else if story.center_target_alpha != undefined
                self.draw.backgroundMono(new FDP.Color(0, 0, 0), story.center_target_alpha)

            if story.time
                self.time_left = story.time

            if story.time_end
                self.time_left = story.time_end - self.total_time


    make_story: () ->

        @story = []
        @story_index = 0

        ###
        s_birth = {mid:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {left:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {up:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        s_birth = {down:img_cry, header:"Birth", statement: "You were born into this world."}
        @story.push(s_birth)
        ###

        @story.push(
                {
                audio:sounds.intro
                ,background: bg_birth
                ,center_text: "2203 A.D."
                ,center_target_alpha: 1.0
                ,time_end: 7390.330000000002
                ,transition_speed: .01
                }
            )

        # Birth, clues the user into what the message is all about.
        @story.push(
                {
                header: ""
                ,statement: ""
                #,audio:sounds.intro
                ,center_text: "Mult"
                ,time_end:8506.860000000002
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                #,audio:sounds.intro
                ,center_text: "Mult"
                ,time_end:9035.420000000002 - 200
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                #,audio:sounds.intro
                ,center_text: "Mult. I."
                ,time_end:9617.365000000002 - 200
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                #,audio:sounds.intro
                ,center_text: "Mult. I. Plier"
                ,time_end: 10000.365000000002
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_evolution
                ,center_text: ""
                ,center_target_alpha: 0.0
                ,time_end: 29054.570000000003 # Objectivity
                ,transition_speed: .1
                }
            )

        
        

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_evolution
                ,center_text: "Objectivity"
                ,center_target_alpha: 0.0
                ,time_end: 32487.760000000006 # Productivity
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_evolution
                ,center_text: "Productivity"
                ,center_target_alpha: 0.0
                ,time_end: 34896.325 # Days of government app
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                #,background:null
                ,center_text: "Days of Government Approved Work."
                ,center_target_alpha: 1.0
                ,time_end: 39396.270000000004 - 200 # multiplied by the physical and mental difficulties
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "x (Physical + Mental Difficulty)"
                ,center_target_alpha: 1.0
                ,time_end: 42812.22 # minus the time wasted on education.
                ,transition_speed: .01
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "- Education Days"
                ,center_target_alpha: 1.0
                ,time_end: 47694.810000000005 # External Standards Beureu
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_external_standards
                ,center_text: ""
                ,center_target_alpha: 0.0
                ,time_end: 62494.02500000001 # Life diploma system.
                ,transition_speed: .2
                }
            )
        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_external_standards
                ,center_text: ""
                ,center_target_alpha: 1.0
                ,time: 400 
                ,transition_speed: .2
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_life_diploma
                ,center_text: ""
                ,center_target_alpha: 0.0
                ,time_end: 78236 # Art making.
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:ill_life_diploma
                ,center_text: "Art making"
                ,center_target_alpha: 1.0
                ,time_end: 78985 # Philosophy
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "Philosophy"
                ,center_target_alpha: 1.0
                ,time_end: 79803 # Etc
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "Etc"
                ,center_target_alpha: 1.0
                ,time_end: 82046.55500000001 # non-productive education days.
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "Non-productive Education Days."
                ,center_target_alpha: 1.0
                ,time_end: 90829.30500000001 # Real work days.
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "Real Work Days."
                ,center_target_alpha: 1.0
                ,time_end: 100134 # Transition to first scene.
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,center_text: "2220 A.D."
                ,center_target_alpha: 1.0
                ,time: 3000 # Transition to first scene.
                ,transition_speed: .1
                }
            )

        @story.push(
                {
                header: ""
                ,statement: ""
                ,background:null
                ,audio:sounds.mother_died
                ,center_text: "Mom died when I was 17."
                ,center_target_alpha: 1.0
                ,time: 3000 # Transition to first scene.
                ,transition_speed: .01
                }
            )


        ###
        ill_evolution
        ill_life_diploma
        ill_mothers_funeral
        ill_external_standards
        ###


        # Mother's death. Introduces the Life Diploma.
        @story.push(
                {left:   img_cry
                ,mid:    img_cry
                ,right:  img_cry
                ,center_target_alpha: 0.0
                ,header: "Mother's Death"
                ,statement: "My Mom died and was buried in a Government Beureu or external standards graveyard."
                ,background:ill_mothers_funeral
                }
            )

        # Artist Graveyard.
        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "Artist Graveyard"
                ,statement: "On my way out I passed by the artist graveyard..."
                ,audio:sounds.musings_from_the_cradle
                ,background:bg_cemetary_artists
                }
            )

        # High School.
        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "High School"
                ,statement: "I enrolled in a STEM centered High School."
                ,audio:sounds.stem_school
                ,background:bg_highschool
                }
            )

        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "railroad"
                ,statement: "I had a fantasy about working for the railroad. It would have increased my physical difficulty multiplier."
                ,audio:sounds.sixteen_tons
                ,background:bg_railroad
                }
            )

        # College studying Information Technology.
        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "college"
                ,statement: "I took the sensible route and enrolled in college to increase my mental difficulty multiplier."
                ,audio:sounds.the_path_of_logic_and_math
                ,background:bg_railroad
                }
            )

        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "Professional IT worker"
                ,statement: "After graduating college, I became an IT worker at an ethical defense contracter located in Manhattan."
                ,audio:sounds.number_crunching
                ,background:bg_professional
                }
            )
             
        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "A plead for the homeless."
                ,statement: "After graduating college, I became an IT worker at an ethical defense contracter."
                ,audio:sounds.plead_for_the_homeless
                ,background:bg_homeless
                }
            )

        @story.push(
                {left:   img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "Dream from Mom"
                ,statement: "A dream from my mother told me to remember the dreams that I had."
                ,audio:sounds.stay_close_to_your_dreams
                ,background:bg_dreams
                }
            )

        @story.push(
               {left:    img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "Older Years"
                ,statement: "From then on, I became an artist and tried to make a unique contribution to the world. I reflected on my life."
                ,audio:sounds.thank_the_lord
                ,background:bg_old_age
                }
            )

        @story.push(
               {left:    img_todo
                ,mid:    img_todo
                ,right:  img_todo
                ,header: "My Funeral"
                ,statement: "I died and was buried in the artist cemetary. A disgrace on the outside, but a fullfilled human being on the inside."
                ,audio:sounds.mother_died_reprise
                ,background:bg_old_age
                }
            )

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
        console.log(@total_time)

    mouse_up: (event) ->

    # Maybe I can put in some feedback here, such as the face that the mouse is in,
    # but for now I'll allow for the tools to do that.
    mouse_move: (event) ->

    # Difference in time between the previous call and this call.
    time: (dt) ->

        @total_time += dt

        # A timer until we transition to the next story state.
        if @time_left != null
            @time_left -= dt

            if @time_left < 0
                # disable timer.
                @time_left = null

                # The timer will be reset if necessary.
                @advance_func()


    window_resize: (event) ->