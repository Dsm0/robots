// // Print available serial ports
// <<< "Available Serial Ports:", "" >>>;
// SerialIO.list() @=> string serialPorts[];
// for (0 => int i; i < serialPorts.size(); i++) {
//     <<< i, ":", serialPorts[i] >>>;
// };



Machine.add(me.dir() + "/serial-robot-server/Handshake.ck");
Machine.add(me.dir() + "/serial-robot-server/HandshakeID.ck");
Machine.add(me.dir() + "/serial-robot-server/SerialBot.ck");



// instantiate a MIDI out object
MidiOut mout;
// a message to work with
MidiMsg msg;


OscOut out;
("localhost", 50000) => out.dest;

// open a MIDI device for output
if( !mout.open("Tammy") ) me.exit();

<<< "MIDI output device opened...", "" >>>;


fun void testSend(int note, int vel){
    0x90 => msg.data1;
    note => msg.data2;
    vel => msg.data3;
    mout.send( msg );
}


fun void testOSCSend(int note, int vel, int delayMS){
    out.start("/tammy");
    out.add(note);
    out.add(vel);
    out.send();
    delayMS::ms => now;
}




// it does not need note offs, but its a good habit
// to get used to sending them
fun void testPlay(int note, int vel, int delayMS){
    testSend(note, vel);   
    delayMS::ms => now;
    testSend(note, 0);
}


fun void playAllNotes(int delayMS) {
    for (127 => int vel; vel > 50; vel - 10 => vel){
        for(0 => int note; note < 127; note++){
            <<< "Playing :", note, vel >>>;
            // testPlay(note, vel, delayMS);    
            testOSCSend(note, vel, delayMS);    
            // delayMS::ms => now;
        }
    }
}

playAllNotes(1000);