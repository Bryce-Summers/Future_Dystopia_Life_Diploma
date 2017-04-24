/*
 * Input main.
 *
 * By Bryce Summers. 4.15.2017
*/
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


function loadAudio(fileName)
{
    //Create the audio tag
    var soundFile = document.createElement("audio");
    soundFile.preload = "auto";

    //Load the sound file (using a source element for expandability)

    var src = document.createElement("source");
    src.src = fileName + ".mp3";
    soundFile.appendChild(src);

    //Load the audio tag
    //It auto plays as a fallback
    soundFile.load();
    soundFile.volume = 0.000000;
    soundFile.play();

    return soundFile;
}

//Plays the sound
function play(soundFile) {
   //Set the current time for the audio file to the beginning
   soundFile.currentTime = 0.01;
   soundFile.volume = 1.0;

   //Due to a bug in Firefox, the audio needs to be played after a delay
   setTimeout(function(){soundFile.play();},1);
}