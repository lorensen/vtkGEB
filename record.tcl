set recording 0;

proc record {} {
  global recording;
  if {$recording == 1} {
    # first open the socket connection
    set cid [socket 3.1.6.107 80];

    # record a frame
    puts $cid "GET /cgi-bin/record.pl?device=/dev/ttyz06/ HTTP/1.0\n";
    flush $cid;

    # check the result and close the channel since it will be closed
    # by the web server
    read $cid;
    close $cid;
    }
}

proc play {start end} {
    # first open the socket connection
    set cid [socket 3.1.6.107 80];

    # play a frame
    puts $cid "GET /cgi-bin/playrange.pl?start=$start&end=$end&device=/dev/ttyz06/ HTTP/1.0\n";
    flush $cid;

    # check the result and close the channel since it will be closed
    # by the web server
    read $cid;
    close $cid;
}


