OscOut out;
("localhost", 50000) => out.dest;

// Marimba MIDI notes
[45, 47, 48, 50, 52, 53, 54, 55, 57, 59, 
60, 62, 64, 65, 66, 67, 69, 71, 72, 74, 
78, 77, 76, 79, 81, 83, 84, 86, 88, 89, 
90, 91, 93, 95, 96] @=> int mScl[];

// Marimba MIDI notes
[45, 47, 48, 50, 52, 53, 54, 55, 57, 59, 
60, 62, 64, 66, 67, 69, 71, 74, 
78, 77, 81, 83, 84, 86, 88, 89, 
90,  93, 96] @=> int mSclWorking[];

// 76, doesn't work,
// 79, 96 not in use

[10,20,30,40,50,60,70,80,90,100,110,120,127] @=> int velRangeTest[];

fun void marimbotSend(int note, int vel){
    out.start("/marimba");
    out.add(note);
    out.add(vel);
    out.send();
}

fun void marimbotPlay(int note, int vel, int msDelay){
   marimbotSend(note, vel);
   msDelay::ms => now;
   marimbotSend(note, 0);
}

fun void marimbotPlayShort(int note, int vel){
   marimbotSend(note, vel);
   100::ms => now;
   marimbotSend(note, 0);
}


fun void shakeShake(int numTimes, int delayTime) {
    <<<"Shake baby">>>;
    for(0 => int i; i < numTimes; i++){
        marimbotPlay(mScl[Math.random2(0, mScl.size()-1)], 60, delayTime);    
    } 
}

fun void playAllNotes(int delayTime) {
    <<<"Playing all Marimbot notes">>>;
    for(0 => int i; i < mSclWorking.size(); i++){
        i => int s;
        <<< "playing ", mSclWorking[s]>>>;
        marimbotPlay(mSclWorking[s], 127, delayTime);    
    }
    for(mSclWorking.size() -1 => int i; i > -1; i--){
        i => int s;
        <<< "playing ", mSclWorking[s]>>>;
        marimbotPlay(mSclWorking[s], 127, delayTime);    
    }
}
fun void arpAllNotesUp(int delayTime) {
    for(0 => int i; i < mSclWorking.size(); i++){
        i => int s;
        // <<< "playing ", mSclWorking[s]>>>;
        marimbotPlay(mSclWorking[s], 127, delayTime);    
    }
}


fun void playNoteVelocityRange(int note, int delayTime) {
    <<<"Playing all Marimbot notes">>>;
    for(0 => int i; i < velRangeTest.size(); i++){
        i => int s;
        marimbotPlayShort(note, velRangeTest[s]);    
        delayTime::ms => now;
    }
    for(velRangeTest.size() -1 => int i; i > -1; i--){
        i => int s;
        marimbotPlayShort(note, velRangeTest[s]);    
        delayTime::ms => now;
    }
}

while(1) {
    <<< "Playing">>>;
    // playAllNotes(100);
    for(0 => int i; i < 10; i++){
        arpAllNotesUp(20 + i * 10);
        // 100::ms => now;
    }
    // playNoteVelocityRange(mScl[17], 200);
    // marimbotPlay(mScl[32], 127,480);    

    // 0.25::second => now;
    // marimbotPlay(mScl[20], 127, 160);    
    // 0.25::second => now;
    // marimbotPlay(mScl[21], 127, 160);    
    // 0.25::second => now;
    // marimbotPlay(mScl[22], 127, 160);    
    // marimbotPlay(62, 127, 160);    
    // 0.25::second => now;
    // <<<"Played ", mScl[12], " and ", mScl[15]>>>;
    // marimbotPlay(mScl[10], 127, 160);    
    // shakeShake(1000, 20);
    // 100::ms => now;
}


// 13 doesn't work
// 18 doesn't work
// 20 doesn't exist
// 34??