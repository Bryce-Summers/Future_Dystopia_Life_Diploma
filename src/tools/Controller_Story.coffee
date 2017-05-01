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


            if story.audio
                if self.current_narrative_audio != null
                    self.current_narrative_audio.pause()
                if story.audio != null
                    play(story.audio)
                    self.current_narrative_audio = story.audio

            # Null goes to a null background.
            if story.background
                self.draw.setBackground(story.background)


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

        # Birth, clues the user into what the message is all about.
        @story.push(
                {left:  img_cry
                ,mid:    img_cry
                ,right:  img_cry
                ,header: "Birth"
                ,statement: "I was born into society in 2103."
                ,audio:sounds.intro
                ,background: bg_birth
                }
            )

        # Mother's death. Introduces the Life Diploma.
        @story.push(
                {left:   img_cry
                ,mid:    img_cry
                ,right:  img_cry
                ,header: "Mother's Death"
                ,statement: "My Mom died and was buried in a Government Beureu or external standards graveyard."
                ,audio:sounds.mother_died
                ,background:bg_cemetary_mainstream
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


    mouse_up: (event) ->

    # Maybe I can put in some feedback here, such as the face that the mouse is in,
    # but for now I'll allow for the tools to do that.
    mouse_move: (event) ->

    # Difference in time between the previous call and this call.
    time: (dt) ->

    window_resize: (event) ->