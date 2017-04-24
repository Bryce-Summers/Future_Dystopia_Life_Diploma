/*
 * Future Dystopia Project.
 * Groundbreaking by Bryce Summers on 4.15.2017
 */

// Small Example scope.
function main()
{
    var canvas = document.getElementById("theCanvas");
    var canvas_G = new BDS.G_Canvas(canvas);

    // Initialize the root Input controller.
    var root_input = init_input(false);

    var controller_state = new FDP.Controller_State();

    var controller_draw  = new FDP.Controller_Draw(canvas_G, controller_state);
    var controller_ui    = new BDS.Controller_UI(canvas_G);

    // -- Tools UI.
    var b1 = new BDS.Box(new BDS.Point(0,   0),
                         new BDS.Point(64, 64));

    var b2 = new BDS.Box(new BDS.Point(64,   0),
                         new BDS.Point(128, 64));

    var p1 = b1.toPolyline();
    var p2 = b2.toPolyline();

    var header       = document.getElementById("header");
    var instructions = document.getElementById("instructions");

    function func()
    {
        header.innerHTML       = "Setting the Header text...";
        instructions.innerHTML = "Setting the Story Text.";
    }

    var img_cry = document.getElementById("img_cry");

    // We put the line drawing button first to encourage people to use it.

    var pts = [];
    for(var i = 0; i < 100; i += Math.PI/100)
    {
        var cx = 1000;
        var cy = 400;
        var radius = 48;

        pts.push(new BDS.Point(cx + radius*Math.cos(i), cy + radius*Math.sin(i)));
    }
    var p1 = new BDS.Polyline(true, pts, true);

    controller_ui.createButton(p1, func, img_cry);
    //controller_ui.createButton(p2, func, img_eraser);
    

    // Layer : Clear the screen and draw the graph.
    root_input.add_universal_controller(controller_draw);    

    // Layer : User Interface.
    root_input.add_universal_controller(controller_ui);

    root_input.add_universal_controller(controller_state);

    // Begin the Amazing Experience!
    beginTime();

}

// Run Example.
window.onload = function()
{
    song = loadAudio("./audio/Thank_the_lord_for the_life_ive_lived");

    play(song);
    main();
}

// -- Root Input functions.
var INPUT; // The global Input Controller than handles time, mouse, keyboard, etc inputs.
function init_input(start_time)
{
    // Initialize the root of the input specification tree.
    INPUT = new BDS.Controller_Group();

    window.addEventListener( 'resize', onWindowResize, false);

    //window.addEventListener("keypress", onKeyPress);
    window.addEventListener("keydown", onKeyPress);

    window.addEventListener("mousemove", onMouseMove);
    window.addEventListener("mousedown", onMouseDown);
    window.addEventListener("mouseup",   onMouseUp);


    // The current system time, used to correctly pass time deltas.
    TIMESTAMP = performance.now();

    // Initialize Time input.
    if(start_time)
    {
        beginTime();
    }

    return INPUT;
}

// Events.
function onWindowResize( event )
{
    
}

// FIXME: ReWire these input events.
function onKeyPress( event )
{
    // Key codes for event.which.
    var LEFT  = 37
    var RIGHT = 39
}

function onMouseMove( event )
{
    event = {x: event.x, y: event.y};
    translateEvent(event);
    INPUT.mouse_move(event);
}

function onMouseDown( event )//event
{
    //http://stackoverflow.com/questions/2405771/is-right-click-a-javascript-event
    var isRightMB;
    event = event || window.event;

    if ("which" in event)  // Gecko (Firefox), WebKit (Safari/Chrome) & Opera
        isRightMB = event.which == 3; 
    else if ("button" in event)  // IE, Opera 
        isRightMB = event.button == 2; 

    // Ignore right bouse button.
    if(isRightMB)
        return

    event = {x: event.x, y: event.y};
    translateEvent(event);
    INPUT.mouse_down(event);
}

function onMouseUp( event )
{
    event = {x: event.x, y: event.y};
    translateEvent(event);
    INPUT.mouse_up(event);
}

function translateEvent(event)
{
    var canvas = document.getElementById("theCanvas");
    var rect   = canvas.getBoundingClientRect();

    event.x = event.x - rect.left;
    event.y = event.y - rect.top;
}

function beginTime()
{
    // Set the canvas reference.
    TIMESTAMP = performance.now();
    INPUT.time_on = true;
    timestep();
}

function timestep()
{
    if(INPUT.time_on)
    {
        requestAnimationFrame(timestep);
    }
    else
    {
        return;
    }

    time_new = performance.now();
    var dt = time_new - TIMESTAMP;
    TIMESTAMP = time_new;

    try
    {
        INPUT.time(dt);
    }
    catch(err) { // Stop time on error.
        INPUT.time_on = false;
        throw err;
    }

}