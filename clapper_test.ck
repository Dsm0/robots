OscOut out;
("localhost", 50000) => out.dest;

while(true) {
    out.start("/clappers");
    out.add(Math.random2(0, 20));
    out.add(127);
    out.send();
    100::ms => now;
}
